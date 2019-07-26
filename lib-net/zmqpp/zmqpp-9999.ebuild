# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils flag-o-matic

DESCRIPTION="ZeroMQ 'highlevel' C++ bindings"
HOMEPAGE="https://github.com/zeromq/zmqpp"
if [[ $PV == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zeromq/zmqpp.git"
else
	SRC_URI="https://github.com/zeromq/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MPL-2.0"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-net/libzmq[static-libs?]"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	sed -i.1 -e "s/DESTINATION\ lib/DESTINATION\ lib/g" "CMakeLists.txt"
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DZEROMQ_LIB_DIR="${ED}"/usr/lib
		-DIS_TRAVIS_CI_BUILD=OFF
		-DZMQPP_BUILD_SHARED=ON
		$(cmake-utils_use static-libs ZMQPP_BUILD_STATIC)
	)

	cmake-utils_src_configure
}
