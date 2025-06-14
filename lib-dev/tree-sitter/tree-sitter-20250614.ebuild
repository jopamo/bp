# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tree-sitter is a parser generator tool and an incremental parsing library"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter"
SNAPSHOT=876d5a96bf05037bd7fd6fa38024c2b64fcc94c2
SRC_URI="https://github.com/tree-sitter/tree-sitter/archive/${SNAPSHOT}.tar.gz -> tree-sitter-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/tree-sitter-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

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
