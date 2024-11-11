# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tree-sitter is a parser generator tool and an incremental parsing library"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter"

SNAPSHOT=51dfe3dbdb7fa230f07df43905ced53e3dcfcc96
SRC_URI="https://github.com/tree-sitter/tree-sitter/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="amd64 arm64"

src_prepare() {
	default
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" \
		  PREFIX="${EPREFIX}/usr" \
		  LIBDIR="${EPREFIX}/usr/lib" \
		  install
}
