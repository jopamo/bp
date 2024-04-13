# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="http://libtorrent.org"
EGIT_REPO_URI="https://github.com/arvidn/libtorrent.git"
EGIT_BRANCH="RC_$(ver_cut 1)_$(ver_cut 2)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-dev/boost
	virtual/ssl
"
DEPEND="${RDEPEND}
	app-build/libtool
"

append-cxxflags -lboost_system

src_configure() {
	local mycmakeargs=(
		-Dstatic_runtime=OFF
		-Dencryption=ON
		-Ddht=ON
		-Ddeprecated-functions=OFF
		-Dexceptions=ON
		-Dlogging=OFF
		-Dbuild_tests=OFF
		)

	cmake_src_configure
}
