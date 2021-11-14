# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="NTP client and server programs"
HOMEPAGE="https://chrony.tuxfamily.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://git.tuxfamily.org/chrony/chrony.git"
	inherit git-r3
else
	SNAPSHOT=a2d1569455aa10a273e41eba5f79ca6210934d68
	SRC_URI="https://git.tuxfamily.org/chrony/chrony.git/snapshot/chrony-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps +cmdmon ipv6 logrotate +ntp +phc pps +refclock +rtc +adns systemd"

DEPEND="
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
