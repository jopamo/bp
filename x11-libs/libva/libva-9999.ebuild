# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Video Acceleration (VA) API for Linux"
HOMEPAGE="https://01.org/linuxmedia/vaapi"
EGIT_REPO_URI="https://github.com/01org/libva"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="+drm opengl wayland X utils"

VIDEO_CARDS="nvidia intel i965 nouveau"
for x in ${VIDEO_CARDS}; do
	IUSE+=" video_cards_${x}"
done

RDEPEND=">=x11-libs/libdrm-2.4.46
	X? (
		>=x11-libs/libX11-1.6.2
		>=x11-libs/libXext-1.3.2
		>=x11-libs/libXfixes-5.0.1
	)
	opengl? ( >=lib-media/mesa-7.0-r1 )
	wayland? ( >=lib-dev/wayland-1.11 )"

DEPEND="${RDEPEND}
	dev-util/pkgconf"
PDEPEND="video_cards_intel? ( >=x11-libs/libva-intel-driver-2.0.0 )
	video_cards_i965? ( >=x11-libs/libva-intel-driver-2.0.0 )
	utils? ( app-media/libva-utils )
	"

REQUIRED_USE="|| ( drm wayland X )
		opengl? ( X )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-drivers-path="${EPREFIX}/usr/lib64/va/drivers"
		$(use_enable opengl glx)
		$(use_enable X x11)
		$(use_enable wayland)
		$(use_enable drm)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
