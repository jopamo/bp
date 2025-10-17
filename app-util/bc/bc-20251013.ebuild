# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An implementation of the POSIX bc calculator with GNU extensions and dc"
HOMEPAGE="https://github.com/gavinhoward/bc"
SNAPSHOT=8a9b0fc7866792c437342039b5f2ae5ee432b79c
SRC_URI="https://github.com/gavinhoward/bc/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	PREFIX="${EPREFIX}"/usr CFLAGS="${CFLAGS}" ./configure.sh -G -T
}
