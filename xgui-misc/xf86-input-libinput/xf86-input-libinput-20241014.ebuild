# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools flag-o-matic

DESCRIPTION="X.org input driver based on libinput"
HOMEPAGE="https://www.x.org"

SNAPSHOT=c712930ef4b544a5036fe2f55fd2ade9efb8ea78
SRC_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-input-libinput/-/archive/${SNAPSHOT}/xf86-input-libinput-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
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
