# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="https://dri.freedesktop.org/"

SNAPSHOT=b65d6ede3ebe64dbde5805007ddef22f390f8050
SRC_URI="https://gitlab.freedesktop.org/mesa/drm/-/archive/${SNAPSHOT}/drm-${SNAPSHOT}.tar.bz2 -> drm-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/drm-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="amdgpu exynos intel libkms nouveau omap radeon udev valgrind"

DEPEND="
	xgui-tools/util-macros
	xgui-lib/cairo
	intel? ( xgui-lib/libpciaccess )
	valgrind? ( app-dev/valgrind )
"

src_configure() {
	local emesonargs=(
		$(meson_feature intel)
		$(meson_feature radeon)
		$(meson_feature amdgpu)
		$(meson_feature nouveau)
		$(meson_feature omap)
		$(meson_feature exynos)
		$(meson_feature valgrind)
		$(meson_use udev)
		-Dvmwgfx=disabled
		-Dman-pages=disabled
	)
	meson_src_configure
}
