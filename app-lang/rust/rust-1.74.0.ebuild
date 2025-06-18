# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic rust-toolchain

RUST_VERSION=1.74.1

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"

SNAPSHOT=44013560b99ee8f351807d5ad4b64ba36bfe7d01
SRC_URI="
	https://github.com/thepowersgang/mrustc/archive/${SNAPSHOT}.tar.gz -> mrustc-${SNAPSHOT}.tar.gz
	https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz
"
S="${WORKDIR}/mrustc-${SNAPSHOT}"

LICENSE="|| ( MIT Apache-2.0 ) BSD-1 BSD-2 BSD-4 UoI-NCSA"
SLOT="0"
KEYWORDS="arm64 amd64"

RESTRICT="test network-sandbox"

RUSTCSRC_VERSION="rustc-${PV}-src"

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

src_prepare() {
	mv "${WORKDIR}/rustc-${RUST_VERSION}-src" "${S}/rustc-$(ver_cut 1-3)-src"

	append-cppflags -D_LARGEFILE64_SOURCE

	filter-clang

	replace-flags -O3 -O2

############# patching rust sources
	pushd rustc-${PV}-src
	sed -i 's/base\.crt_static_default = true;/base\.crt_static_default = false;/g' \
		compiler/rustc_target/src/spec/linux_musl_base.rs || die

	sed -i 's/&\["library", "src\/llvm-project\/libunwind"\],/&\["library"\],/' \
		src/bootstrap/dist.rs || die

	sed -i '
  		/base\.pre_link_objects_self_contained = crt_objects::pre_musl_self_contained();/d
  		/base\.post_link_objects_self_contained = crt_objects::post_musl_self_contained();/d
  		/base\.link_self_contained = LinkSelfContainedDefault::InferredForMusl;/d
		' compiler/rustc_target/src/spec/linux_musl_base.rs || die

	sed -i '
  		/pub(super) fn pre_musl_self_contained() -> CrtObjects {/,/}/d
  		/pub(super) fn post_musl_self_contained() -> CrtObjects {/,/}/d
		' compiler/rustc_target/src/spec/crt_objects.rs || die

	sed -i '/^const _: \[();.*\] = \[();.*std::mem::size_of::<.*>\];/ s/^/\/\//' \
    compiler/rustc_index/src/lib.rs || die

    sed -i '/rustc_index::static_assert_size!(Piece.*16);/ s/^/\/\//' \
    compiler/rustc_parse_format/src/lib.rs || die

    sed -i '/static_assert_size!(Item, 136);/d' compiler/rustc_ast/src/ast.rs || die
	sed -i '/static_assert_size!(ItemKind, 64);/d' compiler/rustc_ast/src/ast.rs || die

	sed -i '/static_assert_size!(TraitItem.*88);/d' compiler/rustc_hir/src/hir.rs || die
	sed -i '/static_assert_size!(TraitItemKind.*48);/d' compiler/rustc_hir/src/hir.rs || die

	sed -i '/static_assert_size/d' compiler/rustc_errors/src/lib.rs || die

	sed -i '/static_assert_size/d' compiler/rustc_const_eval/src/interpret/operand.rs

	sed -i '/static_assert_size/d' \
		compiler/rustc_const_eval/src/interpret/place.rs

	eapply "${FILESDIR}"/rust/*.patch
	eapply "${FILESDIR}"/mrustc_rust/*.patch
	popd

############# patching mrustc sources
	sed -i 's/TargetVersion::Rustc1_29;/TargetVersion::Rustc1_74;/g' src/main.cpp || die

	find . -type f -name Cargo.lock -exec sed -i '
  /^\[\[package\]\]/,/^\[\[/ {
    /name = "libc"/,/^\[\[/ {
      # Replace version = "0.2.xxx" lines
      s/version = "0\.2\.[0-9]*"/version = "0.2.146"/g
      # Replace checksum lines
      s/checksum = "[0-9a-f]\{64\}"/checksum = "f92be4933c13fd498862a9e02a3055f8a8d9c039ce33db97306fd5a6caa7f29b"/g
    }
  }
' {} +

	eapply "${FILESDIR}"/mrustc/*.patch

	sed -i 's/ $(RUSTC_SRC_DL)//' "${S}/minicargo.mk" || die

	eapply_user

	sed -i '/#include <string>/a #include <cstdint>' \
		"rustc-${PV}-src/src/llvm-project/llvm/include/llvm/Support/Signals.h" || die

	MYARCH="$(usex arm64 'AArch64' 'X86')"
	sed -i "s|^LLVM_TARGETS ?=.*|LLVM_TARGETS ?= $MYARCH|" minicargo.mk || die
	sed -i 's|$(MAKE) -j $(PARLEVEL)|$(MAKE) -j $(shell nproc)|g' minicargo.mk || die
	sed -i 's|LLVM_INCLUDE_BENCHMARKS=OFF|LLVM_INCLUDE_BENCHMARKS=OFF LLVM_PARALLEL_LINK_JOBS=1 LLVM_ENABLE_DOXYGEN=OFF|' \
		minicargo.mk || die

	sed -i 's|^LLVM_CONFIG := .*|LLVM_CONFIG := /usr/bin/llvm-config|' minicargo.mk
	sed -i 's|$(OUTDIR)rustc: $(MRUSTC) $(MINICARGO) LIBS $(LLVM_CONFIG)|$(OUTDIR)rustc: $(MRUSTC) $(MINICARGO) LIBS|' minicargo.mk
	sed -i '/$(RUSTCSRC)build\/bin\/llvm-config: $(RUSTCSRC)build\/Makefile/,/$(RUSTCSRC)build\/Makefile: $(RUSTCSRC)$(LLVM_DIR)\/CMakeLists.txt/ d' minicargo.mk
}

src_compile() {
	make_opts=(RUSTC_VERSION=${PV} MRUSTC_TARGET_VER=$(ver_cut 1-2) OUTDIR_SUF="")

	emake ${make_opts[@]}
	emake ${make_opts[@]} RUSTCSRC
	emake ${make_opts[@]} -f minicargo.mk LIBS $@
	emake ${make_opts[@]} test $@
	emake ${make_opts[@]} local_tests $@

	RUSTC_INSTALL_BINDIR=bin emake -j1 ${make_opts[@]} -f minicargo.mk output/rustc $@
	LIBGIT2_SYS_USE_PKG_CONFIG=1 emake -j1 ${make_opts[@]} -f minicargo.mk -j ${PARLEVEL:-1} output/cargo $@

	emake ${make_opts[@]} -C run_rustc
}

src_install() {
	dobin output/cargo
	dobin output/rustc
}
