# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools flag-o-matic

DESCRIPTION="X.org input driver based on libinput"
HOMEPAGE="https://www.x.org"
SNAPSHOT=709d0b0a9a830788340c25e724c31e5a51017e24
SRC_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-input-libinput/-/archive/${SNAPSHOT}/xf86-input-libinput-${SNAPSHOT}.tar.bz2 -> xf86-input-libinput-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xf86-input-libinput-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-util/libinput
	xgui-tools/xorg-server
"

pkg_pretend() {
	CONFIG_CHECK="~TIMERFD"
	check_extra_config
}

src_prepare() {
	filter-flags -Wl,-z,defs

	default
	eautoreconf
}

src_install() {
	default

	insinto /etc/X11/xorg.conf.d
	doins "${FILESDIR}"/40-libinput.conf

}
