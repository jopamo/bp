# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic toolchain-funcs git-r3

DESCRIPTION="PDF rendering library based on the xpdf-3.0 code base"
HOMEPAGE="https://poppler.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/poppler/poppler.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cairo +cjk curl cxx debug doc +introspection +jpeg +jpeg2k +lcms png qt5 tiff +utils"

RESTRICT="test"

COMMON_DEPEND="
	lib-dev/boost
	fonts/fontconfig
	xgui-misc/freetype
	lib-core/zlib
	cairo? (
		lib-live/glib
		xgui-live-lib/cairo
		introspection? ( lib-live/gobject-introspection )
	)
	curl? ( app-net/curl )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	jpeg2k? ( xmedia-live-lib/openjpeg )
	lcms? ( xmedia-live-lib/lcms )
	png? ( xmedia-live-lib/libpng )
	qt5? ( xgui-live-lib/qtbase	)
	tiff? ( xmedia-live-lib/tiff )
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconf
"
RDEPEND="${COMMON_DEPEND}
	cjk? ( app-text/poppler-data )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.60.1-qt5-dependencies.patch"
	"${FILESDIR}/${PN}-0.57.0-disable-internal-jpx.patch"
)

append-cppflags -I/usr/include/openjpeg-2.3

src_prepare() {
	cmake_src_prepare

	# Clang doesn't grok this flag, the configure nicely tests that, but
	# cmake just uses it, so remove it if we use clang
	if [[ ${CC} == clang ]] ; then
		sed -i -e 's/-fno-check-new//' cmake/modules/PopplerMacros.cmake || die
	fi

	if ! grep -Fq 'cmake_policy(SET CMP0002 OLD)' CMakeLists.txt ; then
		sed '/^cmake_minimum_required/acmake_policy(SET CMP0002 OLD)' \
			-i CMakeLists.txt || die
	else
		einfo "policy(SET CMP0002 OLD) - workaround can be removed"
	fi

	# we need to up the C++ version, bug #622526, #643278
	append-cxxflags -std=c++11
}

src_configure() {
	export CMAKE_BUILD_TYPE=RELEASE
	xdg_environment_reset

	local mycmakeargs=(
		-DBUILD_GTK_TESTS=OFF
		-DBUILD_QT5_TESTS=OFF
		-DBUILD_CPP_TESTS=OFF
		-DENABLE_ZLIB=ON
		-DENABLE_ZLIB_UNCOMPRESS=OFF
		-DENABLE_UNSTABLE_API_ABI_HEADERS=ON
		-DUSE_FLOAT=OFF
		-DWITH_Cairo=$(usex cairo)
		-DENABLE_LIBCURL=$(usex curl)
		-DENABLE_CPP=$(usex cxx)
		-DWITH_GObjectIntrospection=$(usex introspection)
		-DWITH_JPEG=$(usex jpeg)
		-DENABLE_DCTDECODER=$(usex jpeg libjpeg none)
		-DENABLE_LIBOPENJPEG=$(usex jpeg2k openjpeg2 none)
		-DENABLE_CMS=$(usex lcms lcms2 none)
		-DWITH_NSS3=OFF
		-DWITH_PNG=$(usex png)
		$(cmake_use_find_package qt5 Qt5Core)
		-DWITH_TIFF=$(usex tiff)
		-DENABLE_UTILS=$(usex utils)
	)

	cmake_src_configure
}
