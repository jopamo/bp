# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="https://dri.freedesktop.org/"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/mesa/drm.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="libkms intel radeon amdgpu nouveau omap exynos valgrind udev"

DEPEND="${RDEPEND}
	x11/util-macros
	valgrind? ( dev-util/valgrind )
	>=lib-dev/libpthread-stubs-0.3-r1:=
	intel? ( >=x11-libs/libpciaccess-0.13.1-r1:= )"

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
