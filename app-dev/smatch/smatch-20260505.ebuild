# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="Static analysis tool for finding bugs in C code"
HOMEPAGE="https://github.com/error27/smatch"
SNAPSHOT=5189e3fb018b783a26dcb45c02c114c1d1aad290
SRC_URI="https://github.com/error27/smatch/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2+ BSD-3 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

DEPEND="
	app-build/llvm
	lib-core/libxml2
	lib-core/sqlite
	virtual/ssl
"
RDEPEND="
	${DEPEND}
	!app-dev/sparse
"
BDEPEND="app-dev/pkgconf"

src_compile() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)" PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
