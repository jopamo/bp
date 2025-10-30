# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools flag-o-matic

DESCRIPTION="X.org input driver based on libinput"
HOMEPAGE="https://www.x.org"
SNAPSHOT=1d7b5c81963b2e4fa5b12fc95f3a62dd69f1ec66
SRC_URI="https://github.com/X11Libre/xf86-input-libinput/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
