# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="http://libtorrent.org"

EGIT_REPO_URI="https://github.com/arvidn/libtorrent.git"
EGIT_BRANCH="RC_1_1"

KEYWORDS="amd64 arm64"
LICENSE="BSD"
SLOT="0"
IUSE="static-libs"

RDEPEND="
	lib-dev/boost
	lib-dev/openssl
"
DEPEND="${RDEPEND}
	sys-devel/libtool
"

src_prepare() {
	append-cxxflags -lboost_system
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
					-Dshared=ON
					-Dstatic_runtime=OFF
					-Dencryption=ON
					-Ddht=ON
					-Ddeprecated-functions=OFF
					-Dexceptions=ON
					-Dlogging=OFF
					-Dbuild_tests=OFF
					)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	use static-libs || rm -f "${ED}"usr/$(get_libdir)/libssh{,_threads}.a
}
