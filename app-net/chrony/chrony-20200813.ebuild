# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd toolchain-funcs autotools

DESCRIPTION="NTP client and server programs"
HOMEPAGE="https://chrony.tuxfamily.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://git.tuxfamily.org/chrony/chrony.git"
	inherit git-r3
else
	SNAPSHOT=aeee1feda6858f833353d9d8baa476ef192953fb
	SRC_URI="https://git.tuxfamily.org/chrony/chrony.git/snapshot/chrony-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps +cmdmon ipv6 +ntp +phc pps +refclock +rtc +adns systemd"

DEPEND="caps? ( lib-sys/libcap )
	lib-sys/libseccomp"

RESTRICT=test

src_prepare() {
	default
	sed -i -e "s/DEVELOPMENT/${PV}/g" "configure" || die
}

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
	dobin chronyc
	dosbin chronyd

	insinto /etc/${PN}
	doins "${FILESDIR}/chrony.conf"

	keepdir /var/{lib,log}/chrony

	insinto /etc/logrotate.d
	newins "${S}/examples/chrony.logrotate" chrony

	use systemd && systemd_dounit "${FILESDIR}/chronyd.service"
}
