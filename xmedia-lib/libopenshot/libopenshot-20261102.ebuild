# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="develop"
PYTHON_COMPAT=( python3_13 )

inherit cmake python-single-r1

DESCRIPTION="Video editing library with Python bindings for OpenShot"
HOMEPAGE="https://www.openshot.org/ https://github.com/OpenShot/libopenshot"
SNAPSHOT=528ebb1539ddd1df8db780776fe087963def1e6b
SRC_URI="https://github.com/OpenShot/libopenshot/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="imagemagick wayland"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	lib-core/libomp
	lib-dev/jsoncpp:=
	xgui-lib/babl
	xgui-lib/qtbase:6=
	xgui-lib/qtsvg:6=
	xmedia-app/ffmpeg[avcodec,avdevice,avformat,avutil,swresample,swscale]
	>=xmedia-lib/libopenshot-audio-20261031
	imagemagick? ( xmedia-app/imagemagick[cxx] )
	wayland? (
		lib-core/glib
		xmedia-lib/pipewire
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-dev/pkgconf
	app-lang/swig
"

src_configure() {
	local mycmakeargs=(
		-DUSE_QT6=ON
		-DENABLE_PYTHON=ON
		-DENABLE_RUBY=OFF
		-DENABLE_JAVA=OFF
		-DENABLE_GODOT=OFF
		-DENABLE_LIB_DOCS=OFF
		-DBUILD_TESTING=OFF
		-DUSE_SYSTEM_JSONCPP=ON
		-DDISABLE_BUNDLED_JSONCPP=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Resvg=ON
		-DENABLE_MAGICK=$(usex imagemagick)
		-DENABLE_OPENCV=OFF
		-DENABLE_WAYLAND_CAPTURE=$(usex wayland)
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DPYTHON_INCLUDE_DIR="$(python_get_includedir)"
		-DPYTHON_LIBRARY="$(python_get_library_path)"
		-DPYTHON_MODULE_PATH="$(python_get_sitedir)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	python_optimize
}
