# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A high-speed compression/decompression library by Google"
HOMEPAGE="https://github.com/google/snappy"
SRC_URI="https://github.com/google/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV%%.*}"
KEYWORDS="amd64 arm64"

src_prepare() {
	local PATCHES=(
		"${FILESDIR}"/snappy-1.1.7-0001-cmake-Add-missing-linking-to-GTEST_LIBRARIES.patch
	)

	# command-line option parsing does not work at all, so just force
	# it off
	sed -i -e '/run_microbenchmarks/s:true:false:' snappy-test.cc || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON

		# gflags does not work anyway
		-DCMAKE_DISABLE_FIND_PACKAGE_Gflags=ON

		# only for benchmarks
		-DHAVE_LIBZ=NO
		-DHAVE_LIBLZO2=NO
	)
	cmake_src_configure
}

src_test() {
	# run tests directly to get verbose output
	cd "${S}" || die
	"${BUILD_DIR}"/snappy_unittest || die
}
