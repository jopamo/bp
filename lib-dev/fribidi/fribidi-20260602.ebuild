# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"

SNAPSHOT=069a7e3d31e6aa74f2068a8e0804106ce7906639
SRC_URI="https://github.com/fribidi/fribidi/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/fribidi-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/glib"

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
