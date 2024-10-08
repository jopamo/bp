# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic rust-toolchain

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"

SNAPSHOT=18275649d86d35aa9e9a40bf73610dfc2279e575
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

	use elibc_musl && export RUSTFLAGS="-Ctarget-feature=-crt-static -Clink-self-contained=on -L/usr/lib -Clink-args=--dynamic-linker /lib/ld-musl-x86_64.so.1 -D_LARGEFILE64_SOURCE"

	append-flags -D_LARGEFILE64_SOURCE

	filter-flags -D_FORTIFY_SOURCE*
	filter-flags -Wl,-O3
	filter-flags -Wl,-z,combreloc
	filter-flags -Wl,-z,defs
	filter-flags -Wl,-z,now
	filter-flags -Wl,-z,relro
	filter-flags -fassociative-math
	filter-flags -fasynchronous-unwind-tables
	filter-flags -fcf-protection=full
	filter-flags -fexceptions
	filter-flags -fgraphite-identity
	filter-flags -fipa-pta
	filter-flags -floop-interchange
	filter-flags -floop-nest-optimize
	filter-flags -floop-parallelize-all
	filter-flags -flto*
	filter-flags -fno-math-errno
	filter-flags -fno-semantic-interposition
	filter-flags -fno-signed-zeros
	filter-flags -fno-trapping-math
	filter-flags -fstack-clash-protection
	filter-flags -fstack-protector-strong
	filter-flags -ftree-loop-distribution
	filter-flags -fuse-linker-plugin

	replace-flags -O3 -O2

	pushd rustc-${PV}-src
	rm "vendor/vte/vim10m_"{match,table}
	eapply -p0 ${S}/rustc-${PV}-src.patch
	sed -i 's/ $(RUSTC_SRC_DL)//' "${S}/minicargo.mk"
	popd

	eapply_user

	ln -s rustc-${PV}-src rustc-1.29.0-src

	ln -sf "${S}/rustc-${PV}-src/vendor" "${S}/rustc-${PV}-src/src/vendor"

	#sed -i '/def download_toolchain(self,/a\ \ \ \ \ \ \ \ print("Download skipped: Toolchain.")\n\ \ \ \ \ \ \ \ return' rustc-${PV}-src/src/bootstrap/bootstrap.py || die
	#sed -i '/def _download_component_helper(self,/a\ \ \ \ \ \ \ \ print("Download skipped: Component {filename}.")\n\ \ \ \ \ \ \ \ return' rustc-${PV}-src/src/bootstrap/bootstrap.py || die
	#sed -i '/def maybe_download_ci_toolchain(self,/a\ \ \ \ \ \ \ \ print("Download skipped: CI Toolchain.")\n\ \ \ \ \ \ \ \ return' rustc-${PV}-src/src/bootstrap/bootstrap.py || die
	#sed -i '/def update_submodules(self,/a\ \ \ \ \ \ \ \ print("Submodule update skipped.")\n\ \ \ \ \ \ \ \ return' rustc-${PV}-src/src/bootstrap/bootstrap.py || die
}

src_compile() {
	local -a make_opts
	PARLEVEL="$(nproc)"
	make_opts=(RUSTC_VERSION=${PV} MRUSTC_TARGET_VER=$(ver_cut 1-2) OUTDIR_SUF="" RUSTC_TARGET=$(rust_abi))

	emake -j1 ${make_opts[@]}
	emake -j1 ${make_opts[@]} -f minicargo.mk LIBS $@
	emake -j1 ${make_opts[@]} RUSTC_INSTALL_BINDIR=bin -f minicargo.mk "output/rustc"
	emake -j1 ${make_opts[@]} LIBGIT2_SYS_USE_PKG_CONFIG=1 -f minicargo.mk "output${OUTDIR_SUF}/cargo"

	pushd rustc-${PV}-src
	"${S}/output/cargo" vendor --locked --sync ./Cargo.toml \
                      --sync ./src/tools/rust-analyzer/Cargo.toml \
                      --sync ./compiler/rustc_codegen_cranelift/Cargo.toml \
                      --sync ./src/bootstrap/Cargo.toml \
                      --sync ./src/tools/cargo/Cargo.toml
	popd

	cd "run_rustc"
	emake -j1
}

src_install() {
	mkdir -p "${D}/usr/"{bin,lib}/
	rustc_wrapper="${S}/run_rustc/output/prefix/bin/rustc"
	sed -i '/LD_LIBRARY_PATH/c\LD_LIBRARY_PATH="$d\/..\/lib\/rustlib\/'$(rust_abi)'\/lib" $d\/rustc_binary $@' ${rustc_wrapper}
	cp -R "${rustc_wrapper}" "${D}/usr/bin/rustc-${PV}" || die "Install failed!"
	cp -R "${S}/run_rustc/output/prefix/bin/rustc_binary" "${D}/usr/bin/rustc_binary" || die "Install failed!"
	cp -R "${S}/run_rustc/output/prefix/bin/cargo" "${D}/usr/bin/cargo-${PV}" || die "Install failed!"
	cp -R "${S}/run_rustc/output/prefix/lib/rustlib" "${D}/usr/lib/rustlib" || die "Install failed!"
	mkdir -p "${D}/etc/env.d/rust/"
	echo /usr/bin/cargo >> "${D}/etc/env.d/rust/provider-rust-${PV}"
}
