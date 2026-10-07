# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=37156835e3d725b6d750f000be33ba3814bb2310
EGIT_REPO_URI="https://github.com/1g4-mirror/sparse.git"
EGIT_COMMIT="${SNAPSHOT}"

inherit git-snapshot toolchain-funcs

DESCRIPTION="Semantic parser and type checker for C"
HOMEPAGE="https://sparse.docs.kernel.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

DEPEND="
	app-build/llvm
	lib-core/libxml2
	lib-core/sqlite
"
BDEPEND+=" app-dev/pkgconf"

sparse_make() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}/usr" SPARSE_VERSION="${PV}+git.${SNAPSHOT}" "$@"
}

src_compile() {
	sparse_make
}

src_install() {
	sparse_make DESTDIR="${D}" install
}
