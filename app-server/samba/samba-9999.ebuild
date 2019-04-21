# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info systemd git-r3 flag-o-matic

EGIT_REPO_URI=https://github.com/samba-team/samba.git
KEYWORDS="amd64 arm64"

DESCRIPTION="Samba Suite Version 4"
HOMEPAGE="https://www.samba.org/"
LICENSE="GPL-3"

SLOT="0"

IUSE="acl -addc -addns -ads -ceph client -cluster cups debug dmapi fam gnutls gpg iprint json -ldap
quota syslog systemd test winbind zeroconf"

CDEPEND="
	>=app-compression/libarchive-3.1.2
	dev-lang/perl:=
	lib-dev/libaio
	lib-dev/libbsd
	lib-dev/iniparser:0
	lib-dev/popt
	lib-net/libnsl:=
	sys-app/attr
	lib-sys/libcap
	lib-sys/ncurses:0=
	lib-sys/readline:0=
	lib-sys/zlib
	lib-sys/pam
	ceph? ( sys-cluster/ceph )
	cluster? (
		lib-net/rpcsvc-proto
		!dev-db/ctdb
	)
	cups? ( lib-print/cups )
	debug? ( dev-util/lttng-ust )
	dmapi? ( sys-app/dmapi )
	fam? ( virtual/fam )
	gnutls? (
		lib-dev/libgcrypt:0
		>=lib-net/gnutls-1.4.0
	)
	gpg? ( app-crypt/gpgme )
	json? ( lib-dev/jansson )
	ldap? ( net-nds/openldap )
	systemd? ( sys-app/systemd:0= )
"
DEPEND="${CDEPEND}
	app-text/docbook-xsl-stylesheets
	lib-dev/libxslt
	dev-lang/python
	lib-net/rpcsvc-proto
	lib-net/libtirpc"
RDEPEND="${CDEPEND}
	client? ( sys-app/cifs-utils[ads?] )
	!dev-perl/Parse-Yapp
"

REQUIRED_USE="
	addc? ( gnutls json winbind )
	ads? ( acl gnutls ldap winbind )
	cluster? ( ads )
	gpg? ( addc )
"

RESTRICT="test"

WAF_BINARY="${S}/buildtools/bin/waf"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default

	# un-bundle dnspython
	sed -i -e '/"dns.resolver":/d' "${S}"/third_party/wscript || die

	# unbundle iso8601 unless tests are enabled
	use test || sed -i -e '/"iso8601":/d' "${S}"/third_party/wscript || die

	sed -e 's:<gpgme\.h>:<gpgme/gpgme.h>:' \
		-i source4/dsdb/samdb/ldb_modules/password_hash.c \
		|| die
}

src_configure() {
	local myconf=(
		--enable-fhs
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--with-pammodulesdir="${EPREFIX}"/usr/lib64/security
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-modulesdir="${EPREFIX}"/usr/lib64/samba
		--with-piddir="${EPREFIX}"/run/${PN}
		--disable-rpath
		--disable-rpath-install
		$(use_with acl acl-support)
		--without-ad-dc
		--without-dnsupdate
		--without-ads
		--without-winbind
		--disable-avahi
		--without-ldap
		--disable-iprint
		$(use_enable ceph cephfs)
		$(use_with cluster cluster-support)
		$(use_enable cups)
		$(use_with dmapi)
		$(use_with fam)
		$(use_with gpg gpgme)
		$(use_enable iprint)
		$(use_with quota quotas)
		$(use_with syslog)
		$(use_with systemd)
		$(usex test '--enable-selftest' '')
		$(use_enable gnutls)
		$(use_with debug lttng)
	)

	CPPFLAGS="-I${SYSROOT}${EPREFIX}/usr/include/et ${CPPFLAGS}" \
		./configure ${myconf[@]}
}

src_install() {
	default

	# create symlink for cups (bug #552310)
	if use cups ; then
		dosym ../../../bin/smbspool /usr/libexec/cups/backend/smb
	fi

	# install example config file
	insinto /etc/samba
	doins examples/smb.conf.default

	# Fix paths in example file (#603964)
	sed \
		-e '/log file =/s@/usr/local/samba/var/@/var/log/samba/@' \
		-e '/include =/s@/usr/local/samba/lib/@/etc/samba/@' \
		-e '/path =/s@/usr/local/samba/lib/@/var/lib/samba/@' \
		-e '/path =/s@/usr/local/samba/@/var/lib/samba/@' \
		-e '/path =/s@/usr/spool/samba@/var/spool/samba@' \
		-i "${ED%/}"/etc/samba/smb.conf.default || die

	systemd_dotmpfilesd "${FILESDIR}"/samba.conf
	systemd_dounit "${FILESDIR}"/nmbd.service
	systemd_dounit "${FILESDIR}"/smbd.{service,socket}
	systemd_newunit "${FILESDIR}"/smbd_at.service 'smbd@.service'
	systemd_dounit "${FILESDIR}"/samba.service

	find "${ED}" -type d -empty -delete
}
