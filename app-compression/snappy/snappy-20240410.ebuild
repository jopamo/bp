# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A high-speed compression/decompression library by Google"
HOMEPAGE="https://github.com/google/snappy"

SNAPSHOT=52820ea9c6cb0af6ebe4920f806dbfbb0de9eaab
SRC_URI="https://github.com/google/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	# command-line option parsing does not work at all, so just force
	# it off
	sed -i -e '/run_microbenchmarks/s:true:false:' snappy-test.cc || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
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