# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson flag-o-matic

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="https://dri.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/mesa/drm.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libkms intel radeon amdgpu nouveau omap exynos valgrind udev"

DEPEND="${RDEPEND}
	x11-live-misc/util-macros
	xgui-live-lib/cairo
	valgrind? ( dev-util/valgrind )
	intel? ( x11-live-lib/libpciaccess )"

append-cppflags -I/usr/include/cairo
append-flags -lcairo

src_configure() {
	local emesonargs=(
		$(meson_use libkms)
		$(meson_use intel)
		$(meson_use radeon)
		$(meson_use amdgpu)
		$(meson_use nouveau)
		$(meson_use omap)
		$(meson_use exynos)
		$(meson_use valgrind)
		$(meson_use udev)
		-Dvmwgfx=false
		-Dman-pages=false
		)
		meson_src_configure
}
