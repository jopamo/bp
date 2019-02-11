# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic

DESCRIPTION="groovy little assembler"
HOMEPAGE="http://www.nasm.us/"
SRC_URI="http://www.nasm.us/pub/nasm/releasebuilds/${PV/_}/${P/_}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-lang/perl"

S=${WORKDIR}/${P/_}

src_prepare() {
	sed -e '/seg_init/d'                      \
    -e 's/pure_func seg_alloc/seg_alloc/' \
    -i include/nasmlib.h

	default
}
