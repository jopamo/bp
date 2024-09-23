# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3 rust-toolchain

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"

MRUSTC_VERSION="0.10.1"
EGIT_REPO_URI="https://github.com/thepowersgang/mrustc.git"
EGIT_COMMIT="666bda127d316e18cce5efc256742899ee2b23a4"

SRC_URI="https://static.rust-lang.org/dist/rustc-${PV}-src.tar.xz"

LICENSE="|| ( MIT Apache-2.0 ) BSD-1 BSD-2 BSD-4 UoI-NCSA"
SLOT="0"
KEYWORDS="arm64 amd64"

S=${WORKDIR}/mrustc-${MRUSTC_VERSION}

RUSTC_VERSION=1.54.0
MRUSTC_TARGET_VER=1.54
OUTDIR_SUF=""

CMAKE_WARN_UNUSED_CLI=no

src_unpack() {
	git-r3_fetch "${EGIT_REPO_URI}" "${EGIT_COMMIT}"
	git-r3_checkout "${EGIT_REPO_URI}" "${S}"
	unpack ${A}
	mv rustc-${PV}-src ${S}
}

src_prepare() {
	filter-flags -D_FORTIFY_SOURCE*
	filter-flags -Wl,-O3
	filter-flags -Wl,-z,defs
	filter-flags -fassociative-math
	filter-flags -fcf-protection=full
	filter-flags -fexceptions
	filter-flags -fgraphite-identity
	filter-flags -floop-interchange
	filter-flags -floop-parallelize-all
	filter-flags -flto*
	filter-flags -fno-math-errno
	filter-flags -fno-semantic-interposition
	filter-flags -fno-signed-zeros
	filter-flags -fno-trapping-math -fexceptions -fpie -fpic -fasynchronous-unwind-tables -fexceptions -Wl,-z,combreloc -Wl,-z,now -Wl,-z,relro
	filter-flags -fstack-protector-strong
	filter-flags -fuse-linker-plugin
    filter-flags -fgraphite-identity
    filter-flags -fipa-pta
    filter-flags -floop-nest-optimize
    filter-flags -flto*
    filter-flags -fstack-clash-protection
    filter-flags -ftree-loop-distribution

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
	make_opts=(RUSTC_VERSION=${RUSTC_VERSION} MRUSTC_TARGET_VER=${MRUSTC_TARGET_VER} OUTDIR_SUF=${OUTDIR_SUF} RUSTC_TARGET=$(rust_abi))

	emake ${make_opts[@]} -f minicargo.mk bin/mrustc
	emake ${make_opts[@]} -f minicargo.mk .
	emake ${make_opts[@]} -f minicargo.mk LIBS
	emake ${make_opts[@]} RUSTC_INSTALL_BINDIR=bin -f minicargo.mk "output/rustc"
	emake ${make_opts[@]} LIBGIT2_SYS_USE_PKG_CONFIG=1 -f minicargo.mk "output${OUTDIR_SUF}/cargo"

	emake -C run_rustc ${make_opts[@]} || die "compile problem"
}

src_install() {
	die
	mkdir -p "${D}/usr/"{bin,lib}/
	rustc_wrapper="${S}/run_rustc/output/prefix/bin/rustc"
	sed -i '/LD_LIBRARY_PATH/c\LD_LIBRARY_PATH="$d\/..\/lib\/rustlib\/'$(rust_abi)'\/lib" $d\/rustc_binary $@' ${rustc_wrapper}
	cp -R "${rustc_wrapper}" "${D}/usr/bin/" || die "Install failed!"
	cp -R "${S}/run_rustc/output/prefix/bin" "${D}/usr/" || die "Install failed!"
	cp -R "${S}/run_rustc/output/prefix/lib/rustlib" "${D}/usr/lib/" || die "Install failed!"

	dosym -r /usr/bin/cargo-1.54.0 /usr/bin/cargo
	dosym -r /usr/bin/rustc-1.54.0 /usr/bin/rustc
}
