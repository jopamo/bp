# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 multilib-minimal versionator

DESCRIPTION="Video Acceleration (VA) API for Linux"
HOMEPAGE="https://01.org/linuxmedia/vaapi"

LICENSE="MIT"
SLOT="0/$(get_version_component_range 1)"
EGIT_REPO_URI="https://github.com/01org/libva"
KEYWORDS="amd64 arm64"

IUSE="+drm opengl wayland X utils"

VIDEO_CARDS="nvidia intel i965 nouveau"
for x in ${VIDEO_CARDS}; do
	IUSE+=" video_cards_${x}"
done

RDEPEND=">=x11-libs/libdrm-2.4.46[${MULTILIB_USEDEP}]
	X? (
		>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXfixes-5.0.1[${MULTILIB_USEDEP}]
	)
	opengl? ( >=lib-media/mesa-7.0-r1[${MULTILIB_USEDEP}] )
	wayland? ( >=lib-dev/wayland-1.11[${MULTILIB_USEDEP}] )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
PDEPEND="video_cards_intel? ( >=x11-libs/libva-intel-driver-2.0.0[${MULTILIB_USEDEP}] )
	video_cards_i965? ( >=x11-libs/libva-intel-driver-2.0.0[${MULTILIB_USEDEP}] )
	utils? ( app-media/libva-utils )
	"

REQUIRED_USE="|| ( drm wayland X )
		opengl? ( X )"

MULTILIB_WRAPPED_HEADERS=(
		/usr/include/va/va_backend_glx.h
		/usr/include/va/va_x11.h
		/usr/include/va/va_dri2.h
		/usr/include/va/va_dricommon.h
		/usr/include/va/va_glx.h
)

src_prepare() {
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-drivers-path="${EPREFIX}/usr/$(get_libdir)/va/drivers"
		$(use_enable opengl glx)
		$(use_enable X x11)
		$(use_enable wayland)
		$(use_enable drm)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
