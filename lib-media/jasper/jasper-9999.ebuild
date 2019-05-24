# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Implementation of the codec specified in the JPEG-2000 Part-1 standard"
HOMEPAGE="https://www.ece.uvic.ca/~mdadams/jasper/"

EGIT_REPO_URI="https://github.com/mdadams/jasper.git"
KEYWORDS="amd64 arm64"

LICENSE="JasPer2.0"
SLOT="0"
IUSE="doc jpeg opengl"

RDEPEND="
	jpeg? ( lib-media/libjpeg-turbo )
	opengl? (
		>=lib-media/mesa-7.0-r1:0
		>=lib-media/freeglut-2.8.1:0
		lib-media/glu
		x11-libs/libXi
		x11-libs/libXmu
	)"
DEPEND="${RDEPEND}
	doc? ( app-text/doxygen )"

src_configure() {
	local mycmakeargs=(
		-DALLOW_IN_SOURCE_BUILD=OFF
		-DBASH_PROGRAM="${EPREFIX}"/bin/bash
		-DJAS_ENABLE_ASAN=OFF
		-DJAS_ENABLE_LSAN=OFF
		-DJAS_ENABLE_MSAN=OFF
		-DJAS_ENABLE_SHARED=ON
		-DJAS_ENABLE_STRICT=ON
		-DJAS_ENABLE_USAN=OFF
		-DCMAKE_INSTALL_DOCDIR=share/doc/${PF}

		# JPEG
		-DJAS_ENABLE_LIBJPEG=$(usex jpeg)
		-DCMAKE_DISABLE_FIND_PACKAGE_JPEG=$(usex !jpeg)

		# OpenGL
		-DJAS_ENABLE_OPENGL=$(usex opengl)
		-DCMAKE_DISABLE_FIND_PACKAGE_OpenGL=$(usex !opengl)

		# Doxygen
		-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=$(usex doc OFF ON)
	)
	cmake-utils_src_configure
}
