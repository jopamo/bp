# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="BLAS, CBLAS, LAPACK, LAPACKE reference implementations"
HOMEPAGE="https://www.netlib.org/lapack/"
SNAPSHOT=8856fad0cfd0efecb57a5325cf097e03a1d3065b
SRC_URI="https://github.com/Reference-LAPACK/lapack/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MPL-2.0"
SLOT="3"
KEYWORDS="amd64 arm64"

src_configure() {
	append-flags -ffat-lto-objects

	local mycmakeargs=(
		-DBUILD_MAN_DOCUMENTATION=ON
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_TESTING=OFF
		-DCBLAS=ON
		-DCMAKE_Fortran_COMPILER=gfortran
		-DCMAKE_SKIP_RPATH=ON
		-DLAPACKE_WITH_TMG=OFF
	)

	cmake_src_configure
}
