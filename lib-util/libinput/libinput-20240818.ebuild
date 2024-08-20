# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Library to handle input devices in Wayland"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/libinput/"

SNAPSHOT=3402f380019dc4f882e1d8627029607aca3f4be6
SRC_URI="https://gitlab.freedesktop.org/libinput/libinput/-/archive/${SNAPSHOT}/libinput-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-util/libevdev
	xgui-misc/mtdev
"

BDEPEND="app-dev/pkgconf"

src_configure() {
	local emesonargs=(
		-Ddebug-gui=false
		-Ddocumentation=false
		-Dtests=false
		-Dlibwacom=false
		-Dudev-dir="${EPREFIX}"/usr/lib/udev
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die
}
