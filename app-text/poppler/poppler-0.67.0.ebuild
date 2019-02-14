# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils flag-o-matic toolchain-funcs xdg-utils

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="git://git.freedesktop.org/git/${PN}/${PN}"
	SLOT="0/9999"
else
	SRC_URI="https://poppler.freedesktop.org/${P}.tar.xz"
	KEYWORDS="amd64 arm64"
	SLOT="0/73"   # CHECK THIS WHEN BUMPING!!! SUBSLOT IS libpoppler.so SOVERSION
fi

DESCRIPTION="PDF rendering library based on the xpdf-3.0 code base"
HOMEPAGE="https://poppler.freedesktop.org/"

LICENSE="GPL-2"
IUSE="cairo cjk curl cxx debug doc +introspection +jpeg +jpeg2k +lcms nss png qt5 tiff +utils"

# No test data provided
RESTRICT="test"

COMMON_DEPEND="
	>=lib-media/fontconfig-2.6.0
	>=lib-media/freetype-2.3.9
	lib-sys/zlib
	cairo? (
		lib-dev/glib:2
		>=x11-libs/cairo-1.10.0
		introspection? ( >=lib-dev/gobject-introspection-1.32.1:= )
	)
	curl? ( app-net/curl )
	jpeg? ( lib-media/libjpeg-turbo )
	jpeg2k? ( lib-media/openjpeg:2= )
	lcms? ( lib-media/lcms:2 )
	nss? ( >=lib-dev/nss-3.19:0 )
	png? ( lib-media/libpng:0= )
	qt5? (
		gui-lib/qtcore:5
		gui-lib/qtgui:5
		gui-lib/qtxml:5
	)
	tiff? ( lib-media/tiff:0 )
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
"
RDEPEND="${COMMON_DEPEND}
	cjk? ( >=app-text/poppler-data-0.4.7 )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.60.1-qt5-dependencies.patch"
	"${FILESDIR}/${PN}-0.61.0-respect-cflags.patch"
	"${FILESDIR}/${PN}-0.62.0-openjpeg2.patch"
	"${FILESDIR}/${PN}-0.57.0-disable-internal-jpx.patch"
)

src_prepare() {
	cmake-utils_src_prepare

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
	xdg_environment_reset
	local mycmakeargs=(
		-DBUILD_GTK_TESTS=OFF
		-DBUILD_QT5_TESTS=OFF
		-DBUILD_CPP_TESTS=OFF
		-DENABLE_SPLASH=ON
		-DENABLE_ZLIB=ON
		-DENABLE_ZLIB_UNCOMPRESS=OFF
		-DENABLE_XPDF_HEADERS=ON
		-DSPLASH_CMYK=OFF
		-DUSE_FIXEDPOINT=OFF
		-DUSE_FLOAT=OFF
		-DWITH_Cairo=$(usex cairo)
		-DENABLE_LIBCURL=$(usex curl)
		-DENABLE_CPP=$(usex cxx)
		-DWITH_GObjectIntrospection=$(usex introspection)
		-DWITH_JPEG=$(usex jpeg)
		-DENABLE_DCTDECODER=$(usex jpeg libjpeg none)
		-DENABLE_LIBOPENJPEG=$(usex jpeg2k openjpeg2 none)
		-DENABLE_CMS=$(usex lcms lcms2 none)
		-DWITH_NSS3=$(usex nss)
		-DWITH_PNG=$(usex png)
		$(cmake-utils_use_find_package qt5 Qt5Core)
		-DWITH_TIFF=$(usex tiff)
		-DENABLE_UTILS=$(usex utils)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# live version doesn't provide html documentation
	if use cairo && use doc && [[ ${PV} != 9999 ]]; then
		# For now install gtk-doc there
		insinto /usr/share/gtk-doc/html/poppler
		doins -r "${S}"/glib/reference/html/*
	fi
}
