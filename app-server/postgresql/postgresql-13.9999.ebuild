# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic python-single-r1 doins git-r3 qa-policy user

DESCRIPTION="PostgreSQL RDBMS"
HOMEPAGE="https://www.postgresql.org/"
EGIT_REPO_URI="https://git.postgresql.org/git/postgresql.git"
EGIT_BRANCH=REL_$(ver_cut 1)_STABLE

LICENSE="POSTGRESQL GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc kerberos ldap nls pam perl python readline
	  +server systemd ssl static-libs tcl threads uuid xml zlib"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CDEPEND="
		app-core/less
		app-build/gettext
		kerberos? ( app-crypto/heimdal )
		ldap? ( app-net/openldap )
		pam? ( lib-core/pam )
		perl? ( >=app-lang/perl-5.8:= )
		python? ( ${PYTHON_DEPS} )
		readline? ( lib-core/readline:0= )
		systemd? ( app-core/systemd )
		ssl? ( virtual/ssl )
		tcl? ( >=app-lang/tcl-8:0= )
		uuid? ( app-core/util-linux[libuuid] )
		xml? ( lib-core/libxml2 lib-core/libxslt )
		zlib? ( lib-core/zlib )
"
RDEPEND="${CDEPEND}"

DEPEND="${CDEPEND}
!!<app-core/sandbox-2.0
app-build/bison
app-build/flex
nls? ( app-build/gettext )
xml? ( app-dev/pkgconf )
"

filter-flags -Wl,-z,defs

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

	default
}

src_configure() {
	export LDFLAGS_SL="${LDFLAGS}"
	export LDFLAGS_EX="${LDFLAGS}"

	qa-policy-configure

	local PO="${EPREFIX%/}"

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
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
		$(use_enable nls)
		$(use_with kerberos gssapi)
		$(use_with ldap)
		$(use_with pam)
		$(use_with perl)
		$(use_with python)
		$(use_with readline)
		$(use_with ssl openssl)
		$(use_with systemd)
		$(use_with tcl)
		$(use_enable threads thread-safety)
		$(use_with uuid uuid e2fs)
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

	if use systemd; then
		dobin "${FILESDIR}/postgresql-check-db-dir"

		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/postgresql.service"
	fi

	newtmpfiles "${FILESDIR}/postgresql.tmpfiles" postgresql.conf

	if use pam; then
		insinto /etc/pam.d
		insopts -m 0644
		newins "${FILESDIR}/postgresql.pam" postgresql
	fi

	qa-policy-install
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process
}
