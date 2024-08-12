# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools flag-o-matic

DESCRIPTION="X.org input driver based on libinput"
HOMEPAGE="https://www.x.org"

SNAPSHOT=bb41cc730c38570f1f90240dcfffb7013895d110
SRC_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-input-libinput/-/archive/${SNAPSHOT}/xf86-input-libinput-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=">=lib-util/libinput-1.5.0:0=
		xgui-tools/xorg-server"

filter-flags -Wl,-z,defs

pkg_pretend() {
	CONFIG_CHECK="~TIMERFD"
	check_extra_config
}

src_prepare() {
	default
	eautoreconf
}
