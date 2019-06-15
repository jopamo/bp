# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"
EGIT_REPO_URI="https://git.llvm.org/git/llvm.git
	https://github.com/llvm-mirror/llvm.git"
EGIT_BRANCH="release_$(ver_cut 1)$(ver_cut 2)"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64"

IUSE="debug doc exegesis libedit +libffi ncurses test xar xml"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release

src_configure() {
	local mycmakeargs=(
		-DLLVM_APPEND_VC_REV=OFF
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DLLVM_LIBDIR_SUFFIX=${libdir#lib}
		-DBUILD_SHARED_LIBS=ON
		-DLLVM_TARGETS_TO_BUILD="${LLVM_TARGETS// /;}"
		-DLLVM_BUILD_TESTS=$(usex test)
		-DLLVM_ENABLE_FFI=$(usex libffi)
		-DLLVM_ENABLE_LIBEDIT=$(usex libedit)
		-DLLVM_ENABLE_TERMINFO=$(usex ncurses)
		-DLLVM_ENABLE_LIBXML2=$(usex xml)
		-DLLVM_ENABLE_ASSERTIONS=$(usex debug)
		-DLLVM_ENABLE_LIBPFM=$(usex exegesis)
		-DLLVM_ENABLE_EH=ON
		-DLLVM_ENABLE_RTTI=ON
		-DWITH_POLLY=OFF # TODO
		-DLLVM_HOST_TRIPLE="${CHOST}"
		-DHAVE_LIBXAR=$(usex xar 1 0)
		-DOCAMLFIND=NO
		-DLLVM_BUILD_DOCS=OFF
		-DLLVM_ENABLE_OCAMLDOC=OFF
		-DLLVM_ENABLE_SPHINX=OFF
		-DLLVM_ENABLE_DOXYGEN=OFF
		-DLLVM_INSTALL_UTILS=ON
		-DLLVM_BINUTILS_INCDIR="${EPREFIX}"/usr/include
	)

	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"
	cmake-utils_src_configure
}

src_test() {
	# respect TMPDIR!
	local -x LIT_PRESERVES_TMP=1
	cmake-utils_src_make check
}
