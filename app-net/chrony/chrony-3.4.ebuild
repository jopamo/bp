# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd toolchain-funcs autotools

DESCRIPTION="NTP client and server programs"
HOMEPAGE="https://chrony.tuxfamily.org/"
SRC_URI="https://download.tuxfamily.org/${PN}/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 arm64"
IUSE="caps +cmdmon ipv6 +ntp +phc pps +refclock +rtc +adns"

DEPEND="
	caps? ( lib-sys/libcap )
	lib-sys/libseccomp
"

RESTRICT=test

S="${WORKDIR}/${P/_/-}"

src_configure() {
	tc-export CC

	local CHRONY_CONFIGURE=(
		$(usex adns '' --disable-asyncdns)
		$(usex caps '' --disable-linuxcaps)
		$(usex cmdmon '' --disable-cmdmon)
		$(usex ipv6 '' --disable-ipv6)
		$(usex ntp '' --disable-ntp)
		$(usex phc '' --disable-phc)
		$(usex pps '' --disable-pps)
		$(usex refclock '' --disable-refclock)
		$(usex rtc '' --disable-rtc)
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--chronyrundir="${EPREFIX}"/run/chrony
		--sysconfdir="${EPREFIX}"/etc/chrony
		--prefix="${EPREFIX}/usr"
		--enable-scfilter
		--without-nss
		--without-readline
		--without-editline
		--without-tomcrypt
	)
	ECONF_SOURCE=${S} ${S}/configure "${CHRONY_CONFIGURE[@]}"
}

src_install() {
	default

	insinto /etc/${PN}
	doins "${FILESDIR}/chrony.conf"

	keepdir /var/{lib,log}/chrony

	insinto /etc/logrotate.d
	newins "${S}/examples/chrony.logrotate" chrony

	systemd_dounit "${FILESDIR}/chronyd.service"

	rm -rf "${ED}"/usr/share/doc "${ED}"/tmp
}
