# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="common Linux command line utilities together into a single BSD-licensed executable "
HOMEPAGE="http://landley.net/toybox/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/landley/toybox"
	inherit git-r3
else
	SNAPSHOT=bf595a0cb0eb132b7365e8f1d19f07b255cbf191
	SRC_URI="https://github.com/landley/toybox/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

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
