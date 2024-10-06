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
	export RUSTFLAGS="${RUSTFLAGS} -Lnative=$("/usr/bin/llvm-config" --libdir)"
	export CARGO_HTTP_CAINFO=/etc/ssl/certs/ca-certificates.crt
	export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
}

src_prepare() {
	if [[ ${PV} == 1.55.0 ]]; then
		eapply "${FILESDIR}/1.54.0-parallel-miri.patch"
	fi

	if [[ ${PV} == 1.57.0 ]]; then
		eapply "${FILESDIR}/1.57.0-selfbootstrap.patch"
	fi

	if [[ ${PV} == 1.61.0 ]]; then
		eapply "${FILESDIR}"/1.61.0-miri-cow.patch
	fi

	if ver_test "${PV}" -gt "1.61.9" && ver_test "${PV}" -lt "1.65.0"; then
		eapply "${FILESDIR}"/1.62.1-musl-dynamic-linking.patch
	fi

	if [[ ${PV} == 1.63.0 ]]; then
		eapply "${FILESDIR}"/1.63.0-CVE-2022-36113.patch
		eapply "${FILESDIR}"/1.63.0-CVE-2022-36114.patch
	fi

	if ver_test "${PV}" -gt "1.55.0" && ver_test "${PV}" -lt "1.65.0"; then
		eapply "${FILESDIR}"/1.55.0-ignore-broken-and-non-applicable-tests.patch
	fi

	if ver_test "${PV}" -gt "1.64.9" && ver_test "${PV}" -lt "1.69.0"; then
		eapply "${FILESDIR}"/1.65.0-ignore-broken-and-non-applicable-tests.patch
	fi

	if ver_test "${PV}" -gt "1.67.9" && ver_test "${PV}" -lt "1.70.0"; then
		eapply "${FILESDIR}"/1.68.0-ignore-broken-and-non-applicable-tests.patch
	fi

	if ver_test "${PV}" -gt "1.67.0" && ver_test "${PV}" -lt "1.72.0"; then
		eapply "${FILESDIR}"/1.67.0-doc-wasm.patch
	fi

	if ver_test "${PV}" -gt "1.69.9" && ver_test "${PV}" -lt "1.78.0"; then
		eapply "${FILESDIR}"/1.70.0-ignore-broken-and-non-applicable-tests.patch
	fi

	if [[ ${PV} == 1.71.0 ]]; then
		eapply "${FILESDIR}"/1.71.1-fix-bootstrap-version-comparison.patch
	fi

	if ver_test "${PV}" -gt "1.72.0" && ver_test "${PV}" -lt "1.74.0"; then
		eapply "${FILESDIR}"/1.72.0-bump-libc-deps-to-0.2.146.patch
	fi

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

	default

	sed -i '/def download_toolchain(self,/a\ \ \ \ \ \ \ \ print("Download skipped: Toolchain.")\n\ \ \ \ \ \ \ \ return' src/bootstrap/bootstrap.py || die
	sed -i '/def _download_component_helper(self,/a\ \ \ \ \ \ \ \ print("Download skipped: Component {filename}.")\n\ \ \ \ \ \ \ \ return' src/bootstrap/bootstrap.py || die
	sed -i '/def maybe_download_ci_toolchain(self,/a\ \ \ \ \ \ \ \ print("Download skipped: CI Toolchain.")\n\ \ \ \ \ \ \ \ return' src/bootstrap/bootstrap.py || die
	sed -i '/def update_submodules(self,/a\ \ \ \ \ \ \ \ print("Submodule update skipped.")\n\ \ \ \ \ \ \ \ return' src/bootstrap/bootstrap.py || die
}

src_configure() {
	cat <<- _EOF_ > "${S}"/config.toml
		[llvm]
		download-ci-llvm = false
		optimize = true
		ninja = true
		link-shared = false
		targets = "$(usex arm64 'AArch64' 'X86')"
		$(usex arm64 '[target.aarch64-unknown-linux-gnu]' '[target.x86_64-unknown-linux-gnu]')
		llvm-config = "/usr/bin/llvm-config"
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
		vendor = true
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
		optimize = false
		lld = false
		rpath = false
		[dist]
		src-tarball = false
	_EOF_
}

src_compile() {
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
