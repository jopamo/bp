# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools user

DESCRIPTION="NTP client and server programs"
HOMEPAGE="https://chrony.tuxfamily.org/"
SNAPSHOT=1bcbea9bd2601fd25ea3dff311f7f258bce76f95
SRC_URI="https://github.com/mlichvar/chrony/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/chrony-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps +cmdmon ipv6 logrotate nettle +ntp +phc pps +refclock +rtc adns systemd tmpfilesd"

DEPEND="
	nettle? ( lib-core/nettle )
	lib-net/gnutls
	app-compression/zstd
	caps? ( lib-core/libcap )
	lib-core/libseccomp
"

RESTRICT=test

src_prepare() {
	default
	sed -i -e "s/DEVELOPMENT/${PV}/g" "configure" || die
}

src_configure() {
	tc-export CC

	local CHRONY_CONFIGURE=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--chronyrundir="${EPREFIX}"/var/run/chrony
		--chronyvardir="${EPREFIX}"/var/lib/chrony
		--sysconfdir="${EPREFIX}"/etc/chrony
		--prefix="${EPREFIX}/usr"
		$(usex adns '' --disable-asyncdns)
		$(usex caps '' --without-libcap)
		$(usex cmdmon '' --disable-cmdmon)
		$(usex ipv6 '' --disable-ipv6)
		$(usex nettle '' --without-nettle)
		$(usex ntp '' --disable-ntp)
		$(usex phc '' --disable-phc)
		$(usex pps '' --disable-pps)
		$(usex refclock '' --disable-refclock)
		$(usex rtc '' --disable-rtc)
		--enable-scfilter
		--without-editline
		--without-nss
		--without-readline
		--without-tomcrypt
		--with-user=chrony
	)
	ECONF_SOURCE=${S} ${S}/configure "${CHRONY_CONFIGURE[@]}"
}

src_install() {
	dobin chronyc
	dobin chronyd

	insinto /etc/chrony
	doins "${FILESDIR}/chrony.conf"

	keepdir /var/log/chrony

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${S}/examples/chrony.logrotate" chrony
	fi

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/chronyd.service"
	fi
}

pkg_preinst() {
	enewgroup chrony 123
	enewuser chrony -1 -1 /var/lib/chrony chrony
}
