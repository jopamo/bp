# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=43b75fbc9ffbc1190fee7c8693ad74cb8286cfd4

inherit autotools

DESCRIPTION="a simple utility for modifying existing ELF executables and libraries"
HOMEPAGE="https://github.com/NixOS/patchelf"
SRC_URI="https://github.com/NixOS/patchelf/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
