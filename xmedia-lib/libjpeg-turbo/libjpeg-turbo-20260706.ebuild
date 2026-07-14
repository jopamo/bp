# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="MMX, SSE, and SSE2 SIMD accelerated JPEG library"
HOMEPAGE="https://libjpeg-turbo.org/"
SNAPSHOT=1db93c29599cf64e5193297b6e2de069c1838d04
SRC_URI="https://github.com/libjpeg-turbo/libjpeg-turbo/archive/${SNAPSHOT}.tar.gz -> libjpeg-turbo-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libjpeg-turbo-${SNAPSHOT}"

LICENSE="BSD IJG"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-lang/nasm"

src_configure() {
	qa-policy-configure
	local mycmakeargs=(
		-DENABLE_STATIC=$(usex static-libs)
		-DWITH_JPEG8=1
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}"/usr/lib
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
