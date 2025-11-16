# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="dev"

inherit meson flag-o-matic

DESCRIPTION="Extremely Fast Compression algorithm"
HOMEPAGE="https://github.com/lz4/lz4"
SNAPSHOT=3773273593de27a7596ff7243efbc2c2768fb7d5
SRC_URI="https://github.com/lz4/lz4/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/lz4-${SNAPSHOT}/build/meson

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

src_configure() {
	append-flags -ffat-lto-objects
	local emesonargs=(
		-Dtests=$(usex test true false)
		-Ddefault_library=$(usex static-libs both shared)
		-Dprograms=true
	)
	meson_src_configure
}
