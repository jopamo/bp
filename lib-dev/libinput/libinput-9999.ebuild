# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Library to handle input devices in Wayland"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/libinput/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/wayland-project/libinput.git"
	inherit git-r3
else
	SRC_URI="https://www.freedesktop.org/software/libinput/${P}.tar.xz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="input_devices_wacom test"

RESTRICT="test"

RDEPEND="
	input_devices_wacom? ( >=lib-dev/libwacom-0.20 )
	>=lib-dev/libevdev-1.3
	>=lib-core/mtdev-1.1"

DEPEND="${RDEPEND}
	dev-util/pkgconf"

src_configure() {
	local emesonargs=(
		-Ddebug-gui=false
		-Ddocumentation=false
		-Dlibwacom="$(usex input_devices_wacom true false)"
		-Dtests="$(usex test true false)"
		-Dudev-dir="${EPREFIX}"/usr/lib/udev
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die
}
