# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"

SNAPSHOT=b28f43bd3e8e31a5967830f721bab218c1aa114c
SRC_URI="https://github.com/fribidi/fribidi/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/fribidi-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-util/glib"

src_prepare() {
	default
	append-flags "-fpermissive -std=gnu17"
}

src_configure() {
	local emesonargs=(
		-Ddocs=false
		)
		meson_src_configure
}
