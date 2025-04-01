# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic rust-toolchain

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"

SNAPSHOT=44013560b99ee8f351807d5ad4b64ba36bfe7d01
SRC_URI="
	https://github.com/thepowersgang/mrustc/archive/${SNAPSHOT}.tar.gz -> mrustc-${SNAPSHOT}.tar.gz
	https://static.rust-lang.org/dist/rustc-$(ver_cut 1-3)-src.tar.xz
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
	mv "${WORKDIR}/rustc-$(ver_cut 1-3)-src" "${S}/rustc-$(ver_cut 1-3)-src"

	append-cppflags -D_LARGEFILE64_SOURCE

	strip-flags

	replace-flags -O3 -O2

	pushd rustc-${PV}-src
	sed -i 's/ $(RUSTC_SRC_DL)//' "${S}/minicargo.mk"
	popd

	eapply_user

	ln -s rustc-${PV}-src rustc-1.29.0-src
	ln -fs ../vendor rustc-${PV}-src/src/vendor

	sed -i '/#include <string>/a #include <cstdint>' \
		"rustc-${PV}-src/src/llvm-project/llvm/include/llvm/Support/Signals.h" || die

	MYARCH="$(usex arm64 'AArch64' 'X86')"
	sed -i "s|^LLVM_TARGETS ?=.*|LLVM_TARGETS ?= $MYARCH|" minicargo.mk || die
	sed -i 's|$(MAKE) -j $(PARLEVEL)|$(MAKE) -j $(shell nproc)|g' minicargo.mk || die
	sed -i 's|LLVM_INCLUDE_BENCHMARKS=OFF|LLVM_INCLUDE_BENCHMARKS=OFF LLVM_PARALLEL_LINK_JOBS=1 LLVM_ENABLE_DOXYGEN=OFF|' \
		minicargo.mk || die
	#sed -i '/^const _: \[();.*std::mem::size_of::<.*>\];/ s/^/\/\//' rustc-$(ver_cut 1-2)-src/compiler/rustc_index/src/lib.rs || die

	#sed -i 's|^LLVM_CONFIG := .*|LLVM_CONFIG := /usr/bin/llvm-config|' minicargo.mk
	#sed -i 's|$(OUTDIR)rustc: $(MRUSTC) $(MINICARGO) LIBS $(LLVM_CONFIG)|$(OUTDIR)rustc: $(MRUSTC) $(MINICARGO) LIBS|' minicargo.mk
	#sed -i '/$(RUSTCSRC)build\/bin\/llvm-config: $(RUSTCSRC)build\/Makefile/,/$(RUSTCSRC)build\/Makefile: $(RUSTCSRC)$(LLVM_DIR)\/CMakeLists.txt/ d' minicargo.mk
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
	mkdir -p "${D}/usr/"{bin,lib}/
	rustc_wrapper="${S}/run_rustc/output/prefix/bin/rustc"
	sed -i '/LD_LIBRARY_PATH/c\LD_LIBRARY_PATH="$d\/..\/lib\/rustlib\/'$(rust_abi)'\/lib" $d\/rustc_binary $@' ${rustc_wrapper}
	cp -R "${rustc_wrapper}" "${D}/usr/bin/rustc-${PV}" || die "Install failed!"
	cp -R "${S}/run_rustc/output/prefix/bin/rustc_binary" "${D}/usr/bin/rustc_binary" || die "Install failed!"
	cp -R "${S}/run_rustc/output/prefix/bin/cargo" "${D}/usr/bin/cargo-${PV}" || die "Install failed!"
	cp -R "${S}/run_rustc/output/prefix/lib/rustlib" "${D}/usr/lib/rustlib" || die "Install failed!"
}
