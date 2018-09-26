# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ ${PV} == *9999* ]] ; then
	EGIT_REPO_URI="https://github.com/mean00/avidemux2.git"
	EGIT_CHECKOUT_DIR=${WORKDIR}
	inherit git-r3
else
	MY_PN="${PN/-core/}"
	MY_P="${MY_PN}_${PV}"
	SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}/${PV}/${MY_P}.tar.gz"
fi
inherit cmake-utils

DESCRIPTION="Core libraries for simple video cutting, filtering and encoding tasks"
HOMEPAGE="http://fixounet.free.fr/avidemux"
KEYWORDS="amd64 arm64 x86"

# Multiple licenses because of all the bundled stuff.
LICENSE="GPL-1 GPL-2 MIT PSF-2 public-domain"
SLOT="2.7"
IUSE="debug nls nvenc sdl vaapi xv"

COMMON_DEPEND="
	lib-sys/sqlite:3
	nvenc? ( app-media/nvidia_video_sdk )
	sdl? ( lib-media/libsdl:0 )
	vaapi? ( x11-libs/libva:0= )
	xv? ( x11-libs/libXv:0 )
"
RDEPEND="${COMMON_DEPEND}
	!<lib-media/avidemux-core-${PV}
	!<app-media/avidemux-${PV}
	nls? ( sys-devel/gettext:0 )
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	dev-lang/yasm[nls=]
"

S="${WORKDIR}/${MY_P}"
CMAKE_USE_DIR="${S}/${PN/-/_}"

src_configure() {
	local mycmakeargs=(
		-DAVIDEMUX_SOURCE_DIR='${S}'
		-DGETTEXT="$(usex nls)"
		-DNVENC="$(usex nvenc)"
		-DSDL="$(usex sdl)"
		-DLIBVA="$(usex vaapi)"
		-DXVIDEO="$(usex xv)"
	)

	if use debug ; then
		mycmakeargs+=( -DVERBOSE=1 -DADM_DEBUG=1 )
	fi

	cmake-utils_src_configure
}
