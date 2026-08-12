# Distributed under the terms of the GNU General Public License v2

inherit cmake flag-o-matic

BRANCH_NAME="$(ver_cut 1).x"
SNAPSHOT=e79bd1a9b3ebc83d3f74106f42384662144dc1d7

DESCRIPTION="neutral and extensible mechanism for serializing structured data"
HOMEPAGE="https://developers.google.com/protocol-buffers/"

SRC_URI="https://github.com/protocolbuffers/protobuf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_configure() {
	append-flags -ffat-lto-objects

	local mycmakeargs=(
		-Dprotobuf_BUILD_TESTS=OFF
		-D FETCHCONTENT_FULLY_DISCONNECTED=false
	)
	cmake_src_configure
}
