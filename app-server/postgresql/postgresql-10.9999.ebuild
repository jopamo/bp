# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit eutils flag-o-matic linux-info multilib pam prefix python-single-r1 \
		systemd user versionator git-r3 multilib-minimal

KEYWORDS="amd64 arm64 x86"

SLOT=$(get_major_version)

EGIT_REPO_URI="https://git.postgresql.org/git/postgresql.git"
EGIT_BRANCH=REL_10_STABLE

LICENSE="POSTGRESQL GPL-2"
DESCRIPTION="PostgreSQL RDBMS"
HOMEPAGE="http://www.postgresql.org/"

IUSE="doc kerberos kernel_linux ldap libressl nls pam perl python +readline
	  selinux +server systemd ssl static-libs tcl threads uuid xml zlib"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CDEPEND="
		sys-app/less
		sys-devel/gettext
		kerberos? ( virtual/krb5 )
		ldap? ( net-nds/openldap )
		pam? ( lib-sys/pam )
		perl? ( >=dev-lang/perl-5.8:= )
		python? ( ${PYTHON_DEPS} )
		readline? ( lib-sys/readline:0= )
		server? ( systemd? ( sys-app/systemd ) )
		ssl? (
			!libressl? ( >=lib-dev/openssl-0.9.6-r1:0= )
			libressl? ( lib-dev/libressl:= )
		)
		tcl? ( >=dev-lang/tcl-8:0= )
		xml? ( lib-dev/libxml2 lib-dev/libxslt )
		zlib? ( lib-sys/zlib )
"

DEPEND="${CDEPEND}
!!<sys-app/sandbox-2.0
sys-devel/bison
sys-devel/flex
nls? ( sys-devel/gettext )
xml? ( dev-util/pkgconfig )
"

RDEPEND="${CDEPEND}
selinux? ( sec-policy/selinux-postgresql )
"

pkg_setup() {
	enewgroup postgres 70
	enewuser postgres 70 /bin/sh /var/lib/postgresql postgres

	use python && python-single-r1_pkg_setup
}

src_prepare() {
	# Work around PPC{,64} compilation bug where bool is already defined
	sed '/#ifndef __cplusplus/a #undef bool' -i src/include/c.h || die

	# Set proper run directory
	sed "s|\(PGSOCKET_DIR\s\+\)\"/tmp\"|\1\"${EPREFIX}/run/postgresql\"|" \
		-i src/include/pg_config_manual.h || die

	# Rely on $PATH being in the proper order so that the correct
	# install program is used for modules utilizing PGXS in both
	# hardened and non-hardened environments. (Bug #528786)
	sed 's/@install_bin@/install -c/' -i src/Makefile.global.in || die

	eapply_user
}

multilib_src_configure() {
	case ${CHOST} in
		*-darwin*|*-solaris*)
			use nls && append-libs intl
			;;
	esac

	export LDFLAGS_SL="${LDFLAGS}"
	export LDFLAGS_EX="${LDFLAGS}"

	local PO="${EPREFIX%/}"

	local i uuid_config=""
	if use uuid; then
		for i in ${UTIL_LINUX_LIBC[@]}; do
			use ${i} && uuid_config="--with-uuid=e2fs"
		done
		for i in ${BSD_LIBC[@]}; do
			use ${i} && uuid_config="--with-uuid=bsd"
		done
		[[ -z $uuid_config ]] && uuid_config="--with-uuid=ossp"
	fi

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--prefix="${PO}/usr/$(get_libdir)/postgresql" \
		--datadir="${PO}/usr/share/postgresql" \
		--docdir="${PO}/usr/share/doc/${PF}" \
		--includedir="${PO}/usr/include/postgresql" \
		--mandir="${PO}/usr/share/postgresql/man" \
		--sysconfdir="${PO}/etc/postgresql" \
		--with-system-tzdata="${PO}/usr/share/zoneinfo" \
		$(use_with ldap)
		$(use_with pam)
		$(use_with perl)
		$(use_with python)
		$(use_with readline)
		$(use_with ssl openssl)
		--with-systemd
		$(use_with tcl)
		${uuid_config}
		$(use_with xml libxml)
		$(use_with xml libxslt)
		$(use_with zlib)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_compile() {
	emake
	emake -C contrib
}

multilib_src_install() {
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" install -C contrib

	use static-libs || find "${ED}" -name '*.a' -delete

	systemd_dounit "${FILESDIR}/postgresql.service"
	systemd_newtmpfilesd "${FILESDIR}/postgresql.tmpfiles" ${PN}.conf

	use pam && pamd_mimic system-auth ${PN} auth account session

		if use prefix ; then
			keepdir /run/postgresql
			fperms 1775 /run/postgresql
		fi
}
