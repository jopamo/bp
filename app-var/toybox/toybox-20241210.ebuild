# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="common Linux command line utilities together into a single BSD-licensed executable "
HOMEPAGE="http://landley.net/toybox/"

SNAPSHOT=69ef8463fff50ad762d1f21de44261de88425b2d
SRC_URI="https://github.com/landley/toybox/archive/${SNAPSHOT}.tar.gz -> toybox-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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