# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Extremely Fast Compression algorithm"
HOMEPAGE="https://github.com/lz4/lz4"

SNAPSHOT=68959d27c3ec37b339b3b8ecfea155faf0ef94f2
SRC_URI="https://github.com/lz4/lz4/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}/build/meson

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

src_configure() {
	local emesonargs=(
		-Dtests=$(usex test true false)
		-Ddefault_library=$(usex static-libs both shared)
		-Dprograms=true
	)
	meson_src_configure
}
