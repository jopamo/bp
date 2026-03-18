# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

BRANCH_NAME="$(ver_cut 1).x"
SNAPSHOT=2ba9b9cf6f0d5917f11fbc0d7362d66901b7511b

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
