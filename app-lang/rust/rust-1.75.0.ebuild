# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic multiprocessing python-any-r1 toolchain-funcs rust-toolchain

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"
SRC_URI="https://static.rust-lang.org/dist/rustc-${PV}-src.tar.xz"
S="${WORKDIR}/rustc-${PV}-src"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-build/llvm
	app-dev/cmake
"

ABI_VER="$(ver_cut 1-2)"

CMAKE_WARN_UNUSED_CLI=no

RESTRICT="test network-sandbox"

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

pkg_setup() {
	python-any-r1_pkg_setup

	export LIBGIT2_NO_PKG_CONFIG=1
	export LLVM_LINK_SHARED=1
	export RUSTFLAGS="${RUSTFLAGS} -Lnative=$("/usr/bin/llvm-config" --libdir)"
	export CARGO_HTTP_CAINFO=/etc/ssl/certs/ca-certificates.crt
	export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
}

src_prepare() {
    if use elibc_musl; then
    	eapply "${FILESDIR}"/rust/*.patch
    	sed -i 's/base\.crt_static_default = true;/base\.crt_static_default = false;/g' \
        	./compiler/rustc_target/src/spec/base/linux_musl.rs || die

        sed -i 's/base\.crt_static_default = true;/base\.crt_static_default = false;/g' \
        	./compiler/rustc_target/src/spec/targets/x86_64_unknown_linux_musl.rs || die

        sed -i 's/^\([[:space:]]*\)extern "C" *{ *}/\1unsafe extern "C" {}/' \
        	library/unwind/src/lib.rs || die

	fi

    filter-clang
    filter-lto

    default
}

src_configure() {
	cat <<- _EOF_ > "${S}"/config.toml
		[llvm]
		assertions = false
		download-ci-llvm = false
		ninja = true
		optimize = true
		release-debuginfo = false
		tests = false
		targets = "$(usex arm64 'AArch64' 'X86')"
		$(usex arm64 "[target.aarch64-unknown-linux-$(usex elibc_musl musl gnu)]" "[target.x86_64-unknown-linux-$(usex elibc_musl musl gnu)]")
		llvm-config = "/usr/bin/llvm-config"
		linker = "clang"
		cc = "clang"
		[build]
		build-stage = 2
		test-stage = 2
		doc-stage = 2
		docs = false
		compiler-docs = false
		python = "${EPYTHON}"
		extended = true
		cargo = "/usr/bin/cargo"
		rustc = "/usr/bin/rustc"
		tools = ["cargo","clippy","src"]
		#tools = ["cargo","clippy","rustdoc","rustfmt","rust-analyzer","rust-analyzer-proc-macro-srv","analysis","src"]
		#tools = ["cargo","clippy","rustfmt","rust-analyzer","rust-analyzer-proc-macro-srv","analysis","src"]
		vendor = true
		sanitizers = false
		optimized-compiler-builtins = true
		[install]
		prefix = "${EPREFIX}/usr"
		sysconfdir = "${EPREFIX}/etc"
		docdir = "share/doc/rust"
		bindir = "bin"
		libdir = "lib"
		mandir = "share/man"
		[rust]
		codegen-units-std = 1
		optimize = 3
		lld = true
		rpath = false
		download-rustc = false
		[dist]
		src-tarball = false
	_EOF_
}

src_compile() {
	export PKG_CONFIG_ALLOW_CROSS=1
	unset RUSTFLAGS

	(
	IFS=$'\n'
	RUST_BACKTRACE=1 "${EPYTHON}" ./x.py build -vv --config="${S}"/config.toml -j$(makeopts_jobs) || die
	)
}

src_install() {
	(
	IFS=$'\n'
	DESTDIR="${D}" "${EPYTHON}" ./x.py install	-vv --config="${S}"/config.toml -j$(makeopts_jobs) || die
	)

	cleanup_install
	dedup_symlink "${ED}"
}
