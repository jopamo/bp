# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic git-r3

DESCRIPTION="ZeroMQ 'highlevel' C++ bindings"
HOMEPAGE="https://github.com/zeromq/zmqpp"
EGIT_REPO_URI="https://github.com/zeromq/zmqpp.git"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-live/libzmq[static-libs?]"

filter-flags -Wl,-z,defs

src_prepare() {
	sed -i.1 -e "s/DESTINATION\ lib/DESTINATION\ lib/g" "CMakeLists.txt"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DZEROMQ_LIB_DIR="${ED}"/usr/lib
		-DIS_TRAVIS_CI_BUILD=OFF
		-DZMQPP_BUILD_SHARED=ON
		-DZMQPP_BUILD_STATIC="$(usex static-libs)"
	)

	cmake_src_configure
}
