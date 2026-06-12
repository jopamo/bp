# Distributed under the terms of the GNU General Public License v2

inherit cmake flag-o-matic toolchain-funcs xdg-utils

DESCRIPTION="PDF rendering library based on the xpdf-3.0 code base"
HOMEPAGE="https://poppler.freedesktop.org/"
SNAPSHOT=3ef748f952ee82fe5153276aec8e67c0b1a5e9cc
SRC_URI="https://gitlab.freedesktop.org/poppler/poppler/-/archive/${SNAPSHOT}/poppler-${SNAPSHOT}.tar.bz2 -> poppler-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/poppler-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cairo curl cxx debug doc introspection jpeg jpeg2k png utils"

RESTRICT="test"

COMMON_DEPEND="
	lib-dev/nss
	fonts/fontconfig
	xgui-lib/freetype
	lib-core/zlib
	cairo? (
		lib-core/glib
		xgui-lib/cairo
		introspection? ( lib-dev/gobject-introspection )
	)
	curl? ( app-net/curl )
	jpeg? ( xmedia-lib/libjpeg-turbo )
	jpeg2k? ( xmedia-lib/openjpeg )
	png? ( xmedia-lib/libpng )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

PATCHES=(
	"${FILESDIR}/poppler-20260226-splashoutputdev-init-color.patch"
)

src_prepare() {
	cmake_src_prepare

	# Clang doesn't grok this flag, the configure nicely tests that, but
	# cmake just uses it, so remove it if we use clang
	if tc-is-clang ; then
		sed -i -e 's/-fno-check-new//' cmake/modules/PopplerMacros.cmake || die
	fi
}

src_configure() {
	export CMAKE_BUILD_TYPE=RELEASE
	xdg_environment_reset
	append-lfs-flags

	local mycmakeargs=(
		-DENABLE_BOOST=OFF
		-DBUILD_CPP_TESTS=OFF
		-DBUILD_GTK_TESTS=OFF
		-DBUILD_MANUAL_TESTS=OFF
		-DBUILD_QT5_TESTS=OFF
		-DBUILD_QT6_TESTS=OFF
		-DRUN_GPERF_IF_PRESENT=OFF
		-DENABLE_CPP=$(usex cxx)
		-DENABLE_GPGME=OFF
		-DENABLE_GLIB=$(usex cairo)
		-DENABLE_GOBJECT_INTROSPECTION=$(usex introspection)
		-DENABLE_LIBCURL=$(usex curl)
		-DENABLE_LIBJPEG=$(usex jpeg)
		-DENABLE_LIBOPENJPEG=$(usex jpeg2k)
		-DENABLE_LCMS=OFF
		-DENABLE_LIBTIFF=OFF
		-DENABLE_NSS3=ON
		-DENABLE_QT5=OFF
		-DENABLE_QT6=OFF
		-DENABLE_UNSTABLE_API_ABI_HEADERS=ON
		-DENABLE_UTILS=$(usex utils)
		-DENABLE_ZLIB_UNCOMPRESS=OFF
		-DCMAKE_DISABLE_FIND_PACKAGE_Cairo=$(usex cairo OFF ON)
		-DCMAKE_DISABLE_FIND_PACKAGE_PNG=$(usex png OFF ON)
	)

	cmake_src_configure
}
