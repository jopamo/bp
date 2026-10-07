# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=979575b829a0a4b4c3e1ca18ca38cc0d16370d90
EGIT_REPO_URI="https://github.com/error27/smatch.git"
EGIT_BRANCH="devel"
EGIT_COMMIT="${SNAPSHOT}"
KERNEL_SNAPSHOT=64507562f8cc88e410b4d29aded8463cee372bde
WINE_SNAPSHOT=f9353d649425244b6d074328440a566ed204d3d6
EGIT_SNAPSHOT_SUBMODULES=(
	"smatch_data/kernel@${KERNEL_SNAPSHOT}@https://github.com/error27/smatch_kernel_data.git"
	"smatch_data/wine@${WINE_SNAPSHOT}@https://github.com/error27/smatch_wine_data.git"
)

inherit git-snapshot toolchain-funcs

DESCRIPTION="Static analysis tool for finding bugs in C code"
HOMEPAGE="https://repo.or.cz/w/smatch.git https://github.com/error27/smatch"

LICENSE="GPL-2+ BSD-3 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-core/libdb
	lib-core/sqlite
	virtual/ssl
"
RDEPEND="
	${DEPEND}
	app-lang/perl
	app-lang/python[sqlite]
	core-perl/DBD-SQLite
	core-perl/Try-Tiny
"
BDEPEND+=" app-dev/pkgconf"

smatch_make() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}/usr" SPARSE_VERSION="${PV}+git.${SNAPSHOT}" \
		smatch_datadir="${EPREFIX}/usr/libexec/smatch" \
		HAVE_LIBXML=no HAVE_SQLITE=no HAVE_GTK=no HAVE_LLVM=no \
		SMATCH_LDFLAGS="${LDFLAGS} -lsqlite3 -lssl -lcrypto -lm" "$@"
}

src_compile() {
	smatch_make
}

src_test() {
	smatch_make check
}

src_install() {
	exeinto /usr/libexec/smatch
	doexe smatch sparse cgcc tagger
	cp -a smatch_data smatch_scripts "${ED}/usr/libexec/smatch/" || die
	dosym ../libexec/smatch/smatch /usr/bin/smatch
}
