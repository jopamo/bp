# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="http://libtorrent.org"
SNAPSHOT=9343c6d3232b131c0295886a5949a673ee0a8c5f
SRC_URI="https://github.com/arvidn/libtorrent/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libtorrent-${SNAPSHOT}"

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
