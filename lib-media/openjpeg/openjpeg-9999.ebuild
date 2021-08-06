# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="An open-source JPEG 2000 library"
HOMEPAGE="http://www.openjpeg.org"
EGIT_REPO_URI="https://github.com/uclouvain/openjpeg.git"

LICENSE="BSD-2"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

DEPEND="
	lib-media/lcms
	lib-media/libpng
	lib-media/tiff
	lib-sys/zlib
"

src_configure() {
	local mycmakeargs=(
		-DOPENJPEG_INSTALL_LIB_DIR="lib"
		-DBUILD_TESTING="$(usex test)"
		-DBUILD_DOC=OFF
		-DBUILD_CODEC=ON
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_STATIC_LIBS="$(usex static-libs)"
		)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	if use static-libs; then
		BUILD_DIR=${BUILD_DIR}_static cmake_src_compile
	fi
}

src_install() {
	if use static-libs; then
		BUILD_DIR=${BUILD_DIR}_static cmake_src_install
	fi

	cmake_src_install
	use static-libs || find "${ED}" -name '*.a' -delete

	dosym /usr/include/openjpeg-2.5/opj_config.h /usr/include/opj_config.h
	dosym /usr/include/openjpeg-2.5/openjpeg.h /usr/include/openjpeg.h
	dosym /usr/include/openjpeg-2.5/opj_stdint.h /usr/include/opj_stdint.h
}
