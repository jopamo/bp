# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Library to handle input devices in Wayland"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/libinput/"
SNAPSHOT=9eae99d4feabd27c318564a66fa676ead87a64d5
SRC_URI="https://gitlab.freedesktop.org/libinput/libinput/-/archive/${SNAPSHOT}/libinput-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/libinput-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-core/libevdev
	xgui-lib/mtdev
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
