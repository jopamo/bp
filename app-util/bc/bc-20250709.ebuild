# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An implementation of the POSIX bc calculator with GNU extensions and dc"
HOMEPAGE="https://github.com/gavinhoward/bc"
SNAPSHOT=6d595fa4d6130e492b3a7fce22ec4a713574ac47
SRC_URI="https://github.com/gavinhoward/bc/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	PREFIX="${EPREFIX}"/usr CFLAGS="${CFLAGS}" ./configure.sh -G -T
}
