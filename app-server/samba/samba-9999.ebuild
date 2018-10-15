# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal linux-info systemd git-r3

EGIT_REPO_URI=https://github.com/samba-team/samba.git
KEYWORDS="amd64 arm64 x86"

DESCRIPTION="Samba Suite Version 4"
HOMEPAGE="https://www.samba.org/"
LICENSE="GPL-3"

SLOT="0"

IUSE="acl -addc -addns -ads -ceph client -cluster cups debug dmapi fam gnutls gpg iprint json -ldap
pam quota selinux syslog systemd test winbind zeroconf"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/samba-4.0/policy.h
	/usr/include/samba-4.0/dcerpc_server.h
	/usr/include/samba-4.0/ctdb.h
	/usr/include/samba-4.0/ctdb_client.h
	/usr/include/samba-4.0/ctdb_protocol.h
	/usr/include/samba-4.0/ctdb_private.h
	/usr/include/samba-4.0/ctdb_typesafe_cb.h
	/usr/include/samba-4.0/ctdb_version.h
)

# sys-app/attr is an automagic dependency (see bug #489748)
CDEPEND="
	>=app-compression/libarchive-3.1.2[${MULTILIB_USEDEP}]
	dev-lang/perl:=
	lib-dev/libaio[${MULTILIB_USEDEP}]
	lib-dev/libbsd[${MULTILIB_USEDEP}]
	lib-dev/iniparser:0
	lib-dev/popt[${MULTILIB_USEDEP}]
	lib-net/libnsl:=[${MULTILIB_USEDEP}]
	sys-app/attr[${MULTILIB_USEDEP}]
	lib-sys/libcap
	lib-sys/ncurses:0=[${MULTILIB_USEDEP}]
	lib-sys/readline:0=
	lib-sys/zlib[${MULTILIB_USEDEP}]
	pam? ( lib-sys/pam )
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
	ldap? ( net-nds/openldap[${MULTILIB_USEDEP}] )
	systemd? ( sys-app/systemd:0= )
"
DEPEND="${CDEPEND}
	app-text/docbook-xsl-stylesheets
	lib-dev/libxslt
	=dev-lang/python-2.7.9999
	lib-net/rpcsvc-proto
	lib-net/libtirpc[${MULTILIB_USEDEP}]"
RDEPEND="${CDEPEND}
	client? ( sys-app/cifs-utils[ads?] )
	selinux? ( sec-policy/selinux-samba )
	!dev-perl/Parse-Yapp
"

REQUIRED_USE="
	addc? ( gnutls json winbind )
	ads? ( acl gnutls ldap winbind )
	cluster? ( ads )
	gpg? ( addc )
"

RESTRICT="test"

PATCHES=(
	"${FILESDIR}/${PN}-4.5.1-compile_et_fix.patch"
)

WAF_BINARY="${S}/buildtools/bin/waf"

src_prepare() {
	default

	# un-bundle dnspython
	sed -i -e '/"dns.resolver":/d' "${S}"/third_party/wscript || die

	# unbundle iso8601 unless tests are enabled
	use test || sed -i -e '/"iso8601":/d' "${S}"/third_party/wscript || die

	sed -e 's:<gpgme\.h>:<gpgme/gpgme.h>:' \
		-i source4/dsdb/samdb/ldb_modules/password_hash.c \
		|| die

	# Friggin' WAF shit
	multilib_copy_sources
}

multilib_src_configure() {
	local myconf=(
		--enable-fhs
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-modulesdir="${EPREFIX}/usr/$(get_libdir)/samba"
		--with-piddir="${EPREFIX}/run/${PN}"
		--disable-rpath
		--disable-rpath-install
		$(multilib_native_use_with acl acl-support)
		--without-ad-dc
		--without-dnsupdate
		--without-ads
		--without-winbind
		--disable-avahi
		--without-ldap
		--disable-iprint
		$(multilib_native_use_enable ceph cephfs)
		$(multilib_native_use_with cluster cluster-support)
		$(multilib_native_use_enable cups)
		$(multilib_native_use_with dmapi)
		$(multilib_native_use_with fam)
		$(multilib_native_use_with gpg gpgme)
		$(multilib_native_use_with json json-audit)
		$(multilib_native_use_enable iprint)
		$(multilib_native_use_with pam)
		$(multilib_native_usex pam "--with-pammodulesdir=${EPREFIX}/$(get_libdir)/security" '')
		$(multilib_native_use_with quota quotas)
		$(multilib_native_use_with syslog)
		$(multilib_native_use_with systemd)
		$(multilib_native_usex test '--enable-selftest' '')
		$(use_enable gnutls)
		$(use_with debug lttng)
	)

	CPPFLAGS="-I${SYSROOT}${EPREFIX}/usr/include/et ${CPPFLAGS}" \
		./configure ${myconf[@]}
}

multilib_src_install() {
	default

	# Make all .so files executable
	#find "${ED}" -type f -name "*.so" -exec chmod +x {} +

	if multilib_is_native_abi ; then
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
	fi
}
