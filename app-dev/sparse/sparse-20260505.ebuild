# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="Semantic parser and type checker for C"
HOMEPAGE="https://github.com/1g4-mirror/sparse"
SNAPSHOT=37156835e3d725b6d750f000be33ba3814bb2310
SRC_URI="https://github.com/1g4-mirror/sparse/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

DEPEND="
	app-build/llvm
	lib-core/libxml2
	lib-core/sqlite
"
BDEPEND="app-dev/pkgconf"

src_compile() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
