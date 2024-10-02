# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3 rust-toolchain

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"

MRUSTC_VERSION="0.10.1"
EGIT_REPO_URI="https://github.com/thepowersgang/mrustc.git"

SRC_URI="https://static.rust-lang.org/dist/rustc-${PV}-src.tar.xz"

LICENSE="|| ( MIT Apache-2.0 ) BSD-1 BSD-2 BSD-4 UoI-NCSA"
SLOT="0"
KEYWORDS="arm64 amd64"

S=${WORKDIR}/mrustc-${MRUSTC_VERSION}

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

src_unpack() {
	git-r3_checkout "${EGIT_REPO_URI}" "${S}"
	unpack ${A}
	mv rustc-${PV}-src ${S}
}

src_prepare() {
	use elibc_musl && export RUSTFLAGS="-Ctarget-feature=-crt-static -Clink-self-contained=on -L/usr/lib -Clink-args=--dynamic-linker /lib/ld-musl-x86_64.so.1"

	use elibc_musl && append-cppflags "-D_LARGEFILE64_SOURCE=0"

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
}

src_compile() {
	local -a make_opts
	PARLEVEL="$(nproc)"
	make_opts=(RUSTC_VERSION=${PV} MRUSTC_TARGET_VER=$(ver_cut 1-2) OUTDIR_SUF="" RUSTC_TARGET=$(rust_abi))

	emake ${make_opts[@]}
	emake -j1 ${make_opts[@]} -f minicargo.mk LIBS $@
	emake -j1 ${make_opts[@]} test $@
	emake -j1 ${make_opts[@]} local_tests $@
	emake -j1 ${make_opts[@]} RUSTC_INSTALL_BINDIR=bin -f minicargo.mk "output/rustc"
	emake -j1 ${make_opts[@]} LIBGIT2_SYS_USE_PKG_CONFIG=1 -f minicargo.mk "output${OUTDIR_SUF}/cargo"

	cd "run_rustc"
	make -j1
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
