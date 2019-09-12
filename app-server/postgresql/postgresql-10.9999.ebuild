# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic linux-info pam prefix python-single-r1 systemd user git-r3

KEYWORDS="amd64 arm64"

SLOT=$(ver_cut 1)

EGIT_REPO_URI="https://git.postgresql.org/git/postgresql.git"
EGIT_BRANCH=REL_$(ver_cut 1)_STABLE

LICENSE="POSTGRESQL GPL-2"
DESCRIPTION="PostgreSQL RDBMS"
HOMEPAGE="http://www.postgresql.org/"

IUSE="doc kerberos ldap nls pam perl python +readline
	  +server systemd ssl static-libs tcl threads uuid xml zlib"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CDEPEND="
		sys-app/less
		sys-devel/gettext
		kerberos? ( app-crypt/heimdal )
		ldap? ( app-net/openldap )
		pam? ( lib-sys/pam )
		perl? ( >=dev-lang/perl-5.8:= )
		python? ( ${PYTHON_DEPS} )
		readline? ( lib-sys/readline:0= )
		server? ( systemd? ( sys-app/systemd ) )
		ssl? ( virtual/ssl )
		tcl? ( >=dev-lang/tcl-8:0= )
		xml? ( lib-dev/libxml2 lib-dev/libxslt )
		zlib? ( lib-sys/zlib )
"

DEPEND="${CDEPEND}
!!<sys-app/sandbox-2.0
sys-devel/bison
sys-devel/flex
nls? ( sys-devel/gettext )
xml? ( dev-util/pkgconf )
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

pkg_setup() {
	enewgroup postgres 70
	enewuser postgres 70 /bin/sh /var/lib/postgresql postgres

	use python && python-single-r1_pkg_setup
}

src_prepare() {
	# Set proper run directory
	sed "s|\(PGSOCKET_DIR\s\+\)\"/tmp\"|\1\"${EPREFIX}/run/postgresql\"|" \
		-i src/include/pg_config_manual.h || die

	# Rely on $PATH being in the proper order
	sed 's/@install_bin@/install -c/' -i src/Makefile.global.in || die

	eapply_user
}

src_configure() {
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
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--prefix="${PO}"/usr/lib/postgresql
		--datadir="${PO}"/usr/share/postgresql
		--docdir="${PO}"/usr/share/doc/${PF}
		--includedir="${PO}"/usr/include/postgresql
		--mandir="${PO}"/usr/share/postgresql/man
		--sysconfdir="${PO}"/etc/postgresql
		--with-system-tzdata="${PO}"/usr/share/zoneinfo
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

src_compile() {
	emake
	emake -C contrib
}

src_install() {
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
