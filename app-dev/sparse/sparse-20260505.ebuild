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
IUSE="+gtk"

DEPEND="
	app-build/llvm
	lib-core/libxml2
	>=lib-core/sqlite-3.24
	gtk? ( xgui-lib/gtk3 )
"
RDEPEND="
	${DEPEND}
	app-lang/perl
"
BDEPEND+=" app-dev/pkgconf"

PATCHES=( "${FILESDIR}/sparsec-use-cc.patch" )

sparse_make() {
	local compiler_include
	compiler_include=$($(tc-getCC) -print-file-name=include) || die
	[[ ${compiler_include} == /* && -d ${compiler_include} ]] ||
		die "Cannot locate compiler builtin headers: ${compiler_include}"

	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" AR="$(tc-getAR)" \
		GCC_BASE="${compiler_include}/.." \
		HAVE_LIBXML=yes HAVE_SQLITE=yes HAVE_LLVM=yes \
		HAVE_GTK="$(usex gtk yes no)" GTK_VERSION=3.0 HAVE_BOOLECTOR=no \
		PREFIX="${EPREFIX}/usr" SPARSE_VERSION="${PV}+git.${SNAPSHOT}" "$@"
}

src_compile() {
	sparse_make
	local tool
	for tool in sparse cgcc c2xml semind sparse-llvm sparsec $(usev gtk test-inspect); do
		[[ -x ${tool} ]] || die "Expected tool ${tool} was not built"
	done
}

src_test() {
	sparse_make check
}

src_install() {
	sparse_make DESTDIR="${D}" install
}
