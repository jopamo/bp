# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools flag-o-matic

DESCRIPTION="X.org input driver based on libinput"
HOMEPAGE="https://www.x.org"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-input-libinput.git"
	inherit git-r3
else
	SRC_URI="https://www.x.org/releases/individual/driver/${P}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=">=lib-live/libinput-1.5.0:0=
		xgui-misc/xorg-server"

filter-flags -Wl,-z,defs

pkg_pretend() {
	CONFIG_CHECK="~TIMERFD"
	check_extra_config
}

src_prepare() {
	default
	eautoreconf
}
