# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="Lightweight Qt Plain-Text Editor"
HOMEPAGE="https://github.com/tsujan/FeatherPad"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/LadybirdBrowser/ladybird"
	inherit git-r3
else
	SNAPSHOT=7895a75c432909ec49bc9957dcb084c55dde42e7
	SRC_URI="https://github.com/tsujan/FeatherPad/archive/${SNAPSHOT}.tar.gz -> FeatherPad-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/FeatherPad-${SNAPSHOT}"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase
	xgui-lib/qtsvg
	app-tex/hunspell
"

RESTRICT="test network-sandbox"

src_configure() {
	# select LLVM toolchain binaries
	local clang_bin
	local clangxx_bin
	local llvm_ar
	local llvm_nm
	local llvm_ranlib
	local lld_bin
	clang_bin="$(type -P clang)" || die "clang not found in PATH"
	clangxx_bin="$(type -P clang++)" || die "clang++ not found in PATH"
	llvm_ar="$(type -P llvm-ar)" || die "llvm-ar not found in PATH"
	llvm_nm="$(type -P llvm-nm)" || die "llvm-nm not found in PATH"
	llvm_ranlib="$(type -P llvm-ranlib)" || die "llvm-ranlib not found in PATH"
	lld_bin="$(type -P ld.lld)" || die "ld.lld not found in PATH"

	# drop GCC-specific flags that clang doesn't understand
	filter-flags -fgraphite-identity -floop-nest-optimize -ftree-loop-distribution -fdevirtualize-at-ltrans -fipa-pta -fuse-linker-plugin
	# optional: if user CFLAGS has a job-count form of LTO like -flto=8, filter it to avoid clang errors
	filter-flags -flto=8

	# prefer lld when using clang
	append-ldflags -fuse-ld=lld

	# export toolchain env so any helper scripts pick up clang
	export CC="${clang_bin}"
	export CXX="${clangxx_bin}"
	export AR="${llvm_ar}"
	export NM="${llvm_nm}"
	export RANLIB="${llvm_ranlib}"
	export LD="${lld_bin}"

	# hand cmake the full LLVM toolchain to keep try-compile and link steps consistent
	local mycmakeargs=(
		-DCMAKE_C_COMPILER="${clang_bin}"
		-DCMAKE_CXX_COMPILER="${clangxx_bin}"
		-DCMAKE_AR="${llvm_ar}"
		-DCMAKE_NM="${llvm_nm}"
		-DCMAKE_RANLIB="${llvm_ranlib}"
		-DENABLE_INSTALL_HEADERS=OFF
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_LINKER="${lld_bin}"
		-DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY  # avoids linking in cmake compiler checks
	)

	cmake_src_configure
}
