# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=3e996dbef1fa0658012f8dd290bddcf0302acade

inherit autotools

DESCRIPTION="a simple utility for modifying existing ELF executables and libraries"
HOMEPAGE="https://github.com/NixOS/patchelf"
SRC_URI="https://github.com/NixOS/patchelf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/patchelf-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
