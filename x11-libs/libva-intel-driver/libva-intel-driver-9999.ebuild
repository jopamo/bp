# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="HW video decode support for Intel integrated graphics"
HOMEPAGE="https://github.com/01org/intel-vaapi-driver"
EGIT_REPO_URI="https://github.com/01org/intel-vaapi-driver.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland X test hybrid_codec"

DEPEND=">=x11-libs/libva-2.0.0:=
	>=lib-gui/libdrm-2.4.52
	wayland? ( >=lib-media/mesa-9.1.6[egl] >=lib-dev/wayland-1.11 )"

src_configure() {
	local emesonargs=(
		$(meson_use X with_x11)
		$(meson_use wayland with_wayland)
		$(meson_use hybrid_codec enable_hybrid_codec)
		$(meson_use test enable_tests)
		)
		meson_src_configure
}
