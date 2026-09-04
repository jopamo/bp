# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="HTML, DOM, CSS, and URL parsing library written in C"
HOMEPAGE="https://github.com/lexbor/lexbor"
SNAPSHOT=1c9970f57558a560b32f0031180687992b3e7989
SRC_URI="https://github.com/lexbor/lexbor/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="!test? ( test )"

src_configure() {
	qa-policy-configure

	local mycmakeargs=(
		-DLEXBOR_OPTIMIZATION_LEVEL=
		-DLEXBOR_BUILD_SHARED=ON
		-DLEXBOR_BUILD_STATIC=$(usex static-libs)
		-DLEXBOR_BUILD_TESTS=$(usex test)
		-DLEXBOR_BUILD_TESTS_CPP=OFF
		-DLEXBOR_BUILD_EXAMPLES=OFF
		-DLEXBOR_BUILD_BENCHMARKS=OFF
		-DLEXBOR_BUILD_UTILS=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
