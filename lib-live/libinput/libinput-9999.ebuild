# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Library to handle input devices in Wayland"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/libinput/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/libinput/libinput"
	inherit git-r3
else
	SRC_URI="https://www.freedesktop.org/software/libinput/${P}.tar.xz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/libevdev
	xgui-misc/mtdev
"

BDEPEND="dev-util/pkgconf"

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
