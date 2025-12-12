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

RESTRICT="test network-sandbox"

BDEPEND="
	app-build/llvm
	app-dev/cmake
"

ABI_VER="$(ver_cut 1-2)"

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

RUST_SYSTEM_LLD=/usr/bin/ld.lld

rust_force_rust_lld() {
	# compute target triple the way you want
	local triple
	triple="$(usex arm64 \
		"aarch64-unknown-linux-$(usex elibc_musl musl gnu)" \
		"x86_64-unknown-linux-$(usex elibc_musl musl gnu)")"

	[[ -x ${RUST_SYSTEM_LLD} ]] || die "${RUST_SYSTEM_LLD} not found, emerge sys-devel/lld"

	# cover both stage2 and stage2-tools since bootstrap may read either
	local base="${S}/build/${triple}"
	local -a cand=(
		"${base}/stage2/lib/rustlib/${triple}/bin"
		"${base}/stage2-tools/lib/rustlib/${triple}/bin"
	)

	local d
	for d in "${cand[@]}"; do
		mkdir -p "${d}" || die "mkdir ${d} failed"
		ln -sf "${RUST_SYSTEM_LLD}" "${d}/rust-lld" || die "link ${d}/rust-lld failed"
	done

	einfo "forced rust-lld -> ${RUST_SYSTEM_LLD} in: ${cand[*]}"
}

pkg_setup() {
	python-any-r1_pkg_setup

	export AR=llvm-ar
	export RANLIB=llvm-ranlib
	export NM=llvm-nm

	export LIBGIT2_NO_PKG_CONFIG=1
	export LLVM_LINK_SHARED=1

	export RUST_MIN_STACK=134217728

	export RUSTFLAGS="${RUSTFLAGS} -Clinker-features=-lld -Lnative=$(/usr/bin/llvm-config --libdir)"

	export CARGO_HTTP_CAINFO=/etc/ssl/certs/ca-certificates.crt
	export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
}

src_prepare() {
	if use elibc_musl; then
		eapply "${FILESDIR}"/rust/*.patch

		local -a musl_specs=(
			compiler/rustc_target/src/spec/base/linux_musl.rs
			compiler/rustc_target/src/spec/targets/x86_64_unknown_linux_musl.rs
			compiler/rustc_target/src/spec/targets/aarch64_unknown_linux_musl.rs
		)

		local f
		for f in "${musl_specs[@]}"; do
			sed -i \
				's/base\.crt_static_default = true;/base\.crt_static_default = false;/g' \
				"${f}" || die
		done

		sed -i \
			's/^\([[:space:]]*\)extern "C" *{ *}/\1unsafe extern "C" {}/' \
			library/unwind/src/lib.rs || die
	fi

	filter-clang
	filter-lto
	default


	eapply "${FILESDIR}"/0003-bootstrap-Workaround-for-system-stage0.patch
	eapply "${FILESDIR}"/0004-compiler-Change-LLVM-targets.patch
	eapply "${FILESDIR}"/0007-compiler-Swap-primary-and-secondary-lib-dirs.patch
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

		$(usex arm64 \
			"[target.aarch64-unknown-linux-$(usex elibc_musl musl gnu)]" \
			"[target.x86_64-unknown-linux-$(usex elibc_musl musl gnu)]")

		llvm-config = "/usr/bin/llvm-config"
		linker = "clang"
		cc = "clang"

		[build]
		docs = false
		compiler-docs = false
		python = "${EPYTHON}"
		extended = true
		cargo = "/usr/bin/cargo"
		rustc = "/usr/bin/rustc"
		tools = ["cargo","clippy","src"]
		vendor = true
		sanitizers = false
		optimized-compiler-builtins = true

		[install]
		prefix = "${EPREFIX}/usr"

		[rust]
		codegen-units-std = 1
		optimize = 3
		llvm-tools = true
		lld = false
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
		RUST_BACKTRACE=1 \
		"${EPYTHON}" ./x.py build -vv --config="${S}/config.toml" \
			--stage 2 compiler/rustc library \
			-j"$(makeopts_jobs)" \
			|| die
	)
}

src_install() {
	rust_force_rust_lld

	(
		IFS=$'\n'
		DESTDIR="${D}" \
		"${EPYTHON}" ./x.py install -vv --config="${S}/config.toml" \
			-j"$(makeopts_jobs)" \
			|| die
	)

	cleanup_install
	dedup_symlink "${ED}"
}
