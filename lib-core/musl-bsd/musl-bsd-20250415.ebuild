# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A standalone library to implement GNU libc's obstack and others"
HOMEPAGE="https://github.com/jopamo/musl-bsd"

SNAPSHOT=7936c598986f75681a5022e7870893cedd97bab7
SRC_URI="https://github.com/jopamo/musl-bsd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="!lib-core/glibc"
