# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=a0151ef25a4d1d262a25247badc44fd146644f9f

inherit autotools flag-o-matic

DESCRIPTION="a simple utility for modifying existing ELF executables and libraries"
HOMEPAGE="https://github.com/NixOS/patchelf"
SRC_URI="https://github.com/NixOS/patchelf/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="amd64 arm64"
# error: 'findSection2' was not declared in this scope, and no declarations were found
# by argument-dependent lookup at the point of instantiation

src_prepare() {
	default
	eautoreconf
}
