# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release-$(ver_cut 1-2)"

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Tree-sitter is a parser generator tool and an incremental parsing library"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter"
SNAPSHOT=c2a14c724a4935849b1ae7f875e09717729b2399
SRC_URI="https://github.com/tree-sitter/tree-sitter/archive/${SNAPSHOT}.tar.gz -> tree-sitter-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/tree-sitter-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0/0.27"
KEYWORDS="amd64 arm64"

src_prepare() {
	append-flags -ffat-lto-objects
	default
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" \
		  PREFIX="${EPREFIX}/usr" \
		  LIBDIR="${EPREFIX}/usr/lib" \
		  install
}
