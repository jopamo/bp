# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic multiprocessing

RUST_VERSION=${PV}

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"

SNAPSHOT=2d14b09a7e75166bec4413f48f61e3b3cd4de8ca
SRC_URI="
	https://github.com/thepowersgang/mrustc/archive/${SNAPSHOT}.tar.gz -> mrustc-${SNAPSHOT}.tar.gz
	https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz
"
S="${WORKDIR}/mrustc-${SNAPSHOT}"

LICENSE="|| ( MIT Apache-2.0 ) BSD-1 BSD-2 BSD-4 UoI-NCSA"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	>=app-build/llvm-22
"

RESTRICT="test"

CMAKE_WARN_UNUSED_CLI=no

QA_FLAGS_IGNORED="
	usr/lib/${PN}/${PV}/bin/.*
	usr/libexec/.*
	usr/lib/lib.*.so
	usr/lib/rustlib/.*/bin/.*
	usr/lib/rustlib/.*/lib/lib.*.so
"

QA_SONAME="
	usr/lib/lib/lib.*.so.*
	usr/lib/rustlib/.*/lib/lib.*.so
"

QA_EXECSTACK="usr/lib/rustlib/*/lib*.rlib:lib.rmeta"

patch_rust_for_system_llvm22() {
	pushd "${S}/rustc-${PV}-src" >/dev/null || die

	# LLVM 22 moved PassPlugin.h from llvm/Passes to llvm/Plugins
	sed -i '/#include "llvm\/Passes\/PassPlugin\.h"/c\
#if __has_include("llvm/Passes/PassPlugin.h")\
#  include "llvm/Passes/PassPlugin.h"\
#elif __has_include("llvm/Plugins/PassPlugin.h")\
#  include "llvm/Plugins/PassPlugin.h"\
#else\
#  error "PassPlugin.h not found"\
#endif' \
		compiler/rustc_llvm/llvm-wrapper/PassWrapper.cpp || die

	# rustc/LLVM combo doesn't accept/advertise amx-transpose
	sed -i \
		-e '/amx-transpose/d' \
		-e '/amx_transpose/d' \
		compiler/rustc_target/src/target_features.rs || die

	# std_detect also lists it and denies unexpected_cfgs
	sed -i \
		-e '/Feature::amx_transpose/d' \
		-e '/amx-transpose/d' \
		-e '/amx_transpose/d' \
		library/std_detect/src/detect/arch/x86.rs \
		library/std_detect/src/detect/os/x86.rs || die

	popd >/dev/null || die
}

src_prepare() {
	mv "${WORKDIR}/rustc-${RUST_VERSION}-src" "${S}/rustc-${PV}-src" || die

	append-cppflags -D_LARGEFILE64_SOURCE
	filter-clang
	replace-flags -O3 -O2

	sed -i 's/TargetVersion::Rustc1_29;/TargetVersion::Rustc1_90;/g' src/main.cpp || die

	grep -q '#include <cstdint>' src/common.hpp || \
		sed -i '/#include <cassert>/a #include <cstdint>' src/common.hpp || die

	eapply "${FILESDIR}"/mrustc/mrustc-0.12.0-RUSTC_SRC_PROVIDED.patch
	eapply "${FILESDIR}"/mrustc/mrustc-0.11.2-dont-strip-bins.patch

	local llvm_ver
	llvm_ver=$(/usr/bin/llvm-config --version) || die
	[[ ${llvm_ver%%.*} == 22 ]] || die "llvm-config 22 required, got ${llvm_ver}"

	local myarch
	myarch="$(usex arm64 'AArch64' 'X86')"
	sed -i "s|^LLVM_TARGETS ?=.*|LLVM_TARGETS ?= ${myarch}|" minicargo.mk || die

	eapply_user
}

src_compile() {
	local -a make_opts=(
		RUSTC_VERSION=${PV}
		MRUSTC_TARGET_VER=$(ver_cut 1-2)
		OUTDIR_SUF=""
		PARLEVEL=$(makeopts_jobs)
		RUSTC_SRC_PROVIDED=1
		RUSTCSRC="${S}/rustc-${PV}-src"
		LLVM_CONFIG=/usr/bin/llvm-config
	)

	einfo "Building mrustc"
	emake "${make_opts[@]}"
	einfo "Preparing bundled rust source tree"
	emake "${make_opts[@]}" RUSTCSRC

	patch_rust_for_system_llvm22

	# keep top-level make single-job here; minicargo itself still uses PARLEVEL
	einfo "Building std/proc_macro with minicargo"
	emake -j1 "${make_opts[@]}" -f minicargo.mk LIBS

	einfo "Building rustc"
	RUSTC_INSTALL_BINDIR=bin emake -j1 "${make_opts[@]}" -f minicargo.mk output/rustc
	einfo "Building cargo"
	LIBGIT2_SYS_USE_PKG_CONFIG=1 emake -j1 "${make_opts[@]}" -f minicargo.mk output/cargo
}

src_install() {
	dobin output/cargo
	dobin output/rustc
}
