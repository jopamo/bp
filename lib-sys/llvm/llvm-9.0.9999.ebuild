# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3 flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"
EGIT_REPO_URI="https://github.com/llvm/llvm-project.git"
EGIT_BRANCH="release/$(ver_cut 1).x"
S=${WORKDIR}/${P}/${PN}

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64"

IUSE="clang debug test"

DEPEND="
	lib-dev/libedit:=
	lib-dev/libffi:=
	lib-sys/ncurses:=
	lib-dev/libxml2:=
"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

src_configure() {
	local mycmakeargs=(
		-DLLVM_ENABLE_PROJECTS=$(usex clang clang '')
		-DLLVM_APPEND_VC_REV=OFF
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DLLVM_LIBDIR_SUFFIX=${libdir#lib}
		-DBUILD_SHARED_LIBS=ON
		-DLLVM_TARGETS_TO_BUILD="AArch64;AMDGPU;BPF;X86"
		-DLLVM_BUILD_TESTS=$(usex test)
		-DLLVM_ENABLE_FFI=ON
		-DLLVM_ENABLE_LIBEDIT=ON
		-DLLVM_ENABLE_TERMINFO=ON
		-DLLVM_ENABLE_LIBXML2=ON
		-DLLVM_ENABLE_ASSERTIONS=$(usex debug)
		-DLLVM_ENABLE_LIBPFM=OFF
		-DLLVM_ENABLE_EH=ON
		-DLLVM_ENABLE_RTTI=ON
		-DWITH_POLLY=OFF # TODO
		-DLLVM_HOST_TRIPLE="${CHOST}"
		-DHAVE_LIBXAR=0
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
