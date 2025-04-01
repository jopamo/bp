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
	if ver_test "${PV}" -gt "1.69.9" && ver_test "${PV}" -lt "1.78.0"; then
		eapply "${FILESDIR}"/1.70.0-ignore-broken-and-non-applicable-tests.patch
	fi

	strip-flags

	replace-flags -O3 -O2

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
		$(usex arm64 '[target.aarch64-unknown-linux-gnu]' '[target.x86_64-unknown-linux-gnu]')
		llvm-config = "/usr/bin/llvm-config"
		cc = "clang"
		cxx = "clang++"
		ar = "llvm-ar"
		ranlib = "llvm-ranlib"
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
		tools = ["cargo","clippy","rustdoc","rustfmt","rust-analyzer","rust-analyzer-proc-macro-srv","analysis","src"]
		vendor = false
		sanitizers = false
		[install]
		prefix = "${EPREFIX}/usr"
		sysconfdir = "etc"
		docdir = "share/doc/rust"
		bindir = "bin"
		libdir = "lib"
		mandir = "share/man"
		[rust]
		codegen-units-std = 1
		optimize = 3
		lld = true
		rpath = false
		[dist]
		src-tarball = false
	_EOF_
}

src_compile() {
	export PKG_CONFIG_ALLOW_CROSS=1
	unset RUSTFLAGS CC CXX

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
}
