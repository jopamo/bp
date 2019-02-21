# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils flag-o-matic

CMAKE_MAKEFILE_GENERATOR=ninja

DESCRIPTION="ZeroMQ 'highlevel' C++ bindings"
HOMEPAGE="https://github.com/zeromq/zmqpp"
if [[ $PV == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zeromq/zmqpp.git"
else
	SRC_URI="https://github.com/zeromq/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS="amd64 arm64"

LICENSE="MPL-2.0"
SLOT="0"
IUSE="static-libs"

DEPEND="lib-net/libzmq[static-libs?]"
RDEPEND="${DEPEND}"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	sed -i.1 -e "s/DESTINATION\ lib/DESTINATION\ $(get_libdir)/g" "CMakeLists.txt"
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DZEROMQ_LIB_DIR="${ED}"/usr/$(get_libdir)
		-DIS_TRAVIS_CI_BUILD=OFF
		-DZMQPP_BUILD_SHARED=ON
		$(cmake-utils_use static-libs ZMQPP_BUILD_STATIC)
	)

	cmake-utils_src_configure
}
