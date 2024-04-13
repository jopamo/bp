# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Video Acceleration (VA) API for Linux"
HOMEPAGE="https://01.org/linuxmedia/vaapi"

SNAPSHOT=1b7d71f68b6ebc7f7c3b80e3eb6b3d888b0463e1
SRC_URI="https://github.com/intel/libva/archive/${SNAPSHOT}.tar.gz -> libva-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libva-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+drm opengl wayland X utils"

RDEPEND=">=xgui-lib/libdrm-2.4.46
	X? (
		>=xgui-lib/libX11-1.6.2
		>=xgui-lib/libXext-1.3.2
		>=xgui-lib/libXfixes-5.0.1
	)
	opengl? ( >=xgui-tools/mesa-7.0-r1 )
	wayland? ( >=xgui-lib/wayland-1.11 )"

REQUIRED_USE="|| ( drm wayland X )
		opengl? ( X )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--with-drivers-path="${EPREFIX}/usr/lib/va/drivers"
		$(use_enable opengl glx)
		$(use_enable X x11)
		$(use_enable wayland)
		$(use_enable drm)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
