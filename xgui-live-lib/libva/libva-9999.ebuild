# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Video Acceleration (VA) API for Linux"
HOMEPAGE="https://01.org/linuxmedia/vaapi"
EGIT_REPO_URI="https://github.com/intel/libva.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+drm opengl wayland X utils"

RDEPEND=">=xgui-live-lib/libdrm-2.4.46
	X? (
		>=xgui-live-lib/libX11-1.6.2
		>=xgui-live-lib/libXext-1.3.2
		>=xgui-live-lib/libXfixes-5.0.1
	)
	opengl? ( >=xgui-misc/mesa-7.0-r1 )
	wayland? ( >=xgui-live-lib/wayland-1.11 )"

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
