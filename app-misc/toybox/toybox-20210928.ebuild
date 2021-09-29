# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=340b1cf8f79cc9ea7232453e0052d2418c806103

inherit flag-o-matic

DESCRIPTION="common Linux command line utilities together into a single BSD-licensed executable "
HOMEPAGE="http://landley.net/toybox/"
SRC_URI="https://github.com/landley/toybox/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test strip"

BDEPEND="lib-core/musl"

append-ldflags -static

src_compile() {
	export OPTIMIZE="${CFLAGS}"
	export CC=musl-gcc
	default
}

src_install() {
	dobin toybox
}
