# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit toolchain-funcs python-r1 git-r3 cmake-utils

DESCRIPTION="A compositor for X, and a fork of xcompmgr-dana"
HOMEPAGE="https://github.com/yshui/compton.git"

EGIT_REPO_URI="https://github.com/yshui/compton.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="doc dbus +drm opengl +pcre xinerama"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="${PYTHON_DEPS}
	lib-dev/libconfig:=
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXrender
	dbus? ( sys-app/dbus )
	opengl? ( lib-media/mesa )
	pcre? ( lib-dev/libpcre:3 )
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${COMMON_DEPEND}
	x11/xprop
	x11/xwininfo"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	x11/xorgproto
	drm? ( x11-libs/libdrm )"

PATCHES=( "${FILESDIR}/noasciidoc.patch" )

src_prepare() {
	default
	mv _CMakeLists.txt CMakeLists.txt
}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	python_foreach_impl python_newscript bin/compton-convgen.py compton-convgen
	rm -rf ${ED}/usr/share/icons
}
