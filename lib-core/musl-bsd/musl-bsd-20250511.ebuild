# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A standalone library to implement GNU libc's obstack and others"
HOMEPAGE="https://github.com/jopamo/musl-bsd"

SNAPSHOT=13afd4738e330df66decb37657ebdc53aadd0b24
SRC_URI="https://github.com/jopamo/musl-bsd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="!lib-core/glibc"
