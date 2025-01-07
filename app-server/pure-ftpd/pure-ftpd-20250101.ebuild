# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools user

DESCRIPTION="Fast, production-quality, standard-conformant FTP server"
HOMEPAGE="http://www.pureftpd.org/"

SNAPSHOT=de9d0b1a8da45b1c82c76021f797dcfe5055f3c4
SRC_URI="https://github.com/jedisct1/pure-ftpd/archive/${SNAPSHOT}.tar.gz -> pure-ftpd-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pure-ftpd-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps implicittls ldap mysql noiplog pam paranoidmsg postgres resolveids ssl systemd vchroot"

REQUIRED_USE="implicittls? ( ssl )"

DEPEND="caps? ( lib-core/libcap )
	ldap? ( app-net/openldap )
	mysql? ( app-server/mariadb )
	pam? ( lib-core/pam )
	postgres? ( app-server/postgresql )
	ssl? ( virtual/ssl )"

RDEPEND="lib-util/libsodium"

pkg_setup() {
	enewgroup ftp
	enewuser ftp -1 -1 /var/ftp ftp
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# adjust max user length to something more appropriate
	# for virtual hosts. See bug #62472 for details.
	sed -e "s:# define MAX_USER_LENGTH 32U:# define MAX_USER_LENGTH 127U:" \
		-i "${S}/src/ftpd.h" || die "sed failed"

	use resolveids && append-cppflags -DALWAYS_RESOLVE_IDS

	# Do not auto-use SSP -- let the user select this.
	export ax_cv_check_cflags___fstack_protector_all=no

	local myconf=(
		--enable-largefile
		--with-altlog
		--with-cookie
		--with-diraliases
		--with-extauth
		--with-ftpwho
		--with-language=${PUREFTPD_LANG:=english}
		--with-peruserlimits
		--with-privsep
		--with-puredb
		--with-quotas
		--with-ratios
		--with-throttling
		--with-uploadscript
		--with-virtualhosts
		$(use_with ldap)
		$(use_with mysql)
		$(use_with pam)
		$(use_with paranoidmsg)
		$(use_with postgres pgsql)
		$(use_with ssl tls)
		$(use_with implicittls)
		$(use_with vchroot virtualchroot)
		$(usex caps '' '--without-capabilities')
		$(usex noiplog '--without-iplogging' '')
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	if use implicittls ; then
		sed -i '/^SERVER/s@21@990@' "${ED}"/etc/conf.d/${PN} \
			|| die "Adjusting default server port for implicittls usage failed!"
	fi

	keepdir /var/lib/run/${PN}

	if use ldap ; then
		insinto /etc/openldap/schema
		doins pureftpd.schema
		insinto /etc/openldap
		insopts -m 0600
		doins pureftpd-ldap.conf
	fi

	 if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	fi
}
