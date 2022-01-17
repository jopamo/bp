# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=bdb09e90f75406068b061a69a3bde3878e5287fa

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
