# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="Userspace interface to the Linux kernel DRM subsystem"
HOMEPAGE="https://dri.freedesktop.org/"
SNAPSHOT=d72d7c6eef64ad2e200b0f1fa8cd2447b9a6c660
SRC_URI="https://gitlab.freedesktop.org/mesa/drm/-/archive/${SNAPSHOT}/drm-${SNAPSHOT}.tar.bz2 -> drm-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libdrm-${SNAPSHOT}"

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
	filter-flags -flto*

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
		-Dtests=false
	)
	meson_src_configure
}
