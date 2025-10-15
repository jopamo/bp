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

RUST_SYSTEM_LLD=/usr/bin/ld.lld

rust_force_rust_lld() {
	# compute target triple the way you want
	local TRIPLE="$(usex arm64 aarch64-unknown-linux-$(usex elibc_musl musl gnu) x86_64-unknown-linux-$(usex elibc_musl musl gnu))"

	[[ -x ${RUST_SYSTEM_LLD} ]] || die "${RUST_SYSTEM_LLD} not found, emerge sys-devel/lld"

	# cover both stage2 and stage2-tools since bootstrap may read either
	local BASE="${S}/build/${TRIPLE}"
	local -a CAND=(
		"${BASE}/stage2/lib/rustlib/${TRIPLE}/bin"
		"${BASE}/stage2-tools/lib/rustlib/${TRIPLE}/bin"
	)

	for d in "${CAND[@]}"; do
		mkdir -p "${d}" || die "mkdir ${d} failed"
		ln -sf "${RUST_SYSTEM_LLD}" "${d}/rust-lld" || die "link ${d}/rust-lld failed"
	done

	einfo "forced rust-lld -> ${RUST_SYSTEM_LLD} in: ${CAND[*]}"
}

pkg_setup() {
	python-any-r1_pkg_setup

	export AR=llvm-ar
	export RANLIB=llvm-ranlib
	export NM=llvm-nm
	export LIBGIT2_NO_PKG_CONFIG=1
	export LLVM_LINK_SHARED=1
	export RUSTFLAGS="${RUSTFLAGS} -Clinker-features=-lld -Lnative=$("/usr/bin/llvm-config" --libdir)"
	export CARGO_HTTP_CAINFO=/etc/ssl/certs/ca-certificates.crt
	export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
}

src_prepare() {
  [[ -x /usr/bin/ld.lld ]] || die "/usr/bin/ld.lld not found, emerge sys-devel/lld"

  # 1) force initial_lld to system ld.lld wherever it appears
  grep -RIl 'let[[:space:]]\+initial_lld' src/bootstrap/src \
  | xargs -r sed -Ei \
    's#let[[:space:]]+initial_lld[[:space:]]*=[[:space:]]*initial_target_dir[[:space:]]*\.join\([[:space:]]*"bin"[[:space:]]*\)[[:space:]]*\.join\([[:space:]]*"rust-lld"[[:space:]]*\);#let initial_lld = std::path::PathBuf::from("/usr/bin/ld.lld");#'

  # 2) replace any rust-lld installer copy with a safe block that uses /usr/bin/ld.lld and skips if unavailable
  #    this eats the "src.symlink_metadata()" panic entirely
  for f in src/bootstrap/src/lib.rs src/bootstrap/src/dist.rs src/bootstrap/src/compile.rs; do
    [[ -f "$f" ]] || continue
    perl -0777 -pe '
      s#
        let\s+src\s*=\s*[^;]*join\(\s*"rust-lld"\s*\)\s*;\s*
        t!\(src\.symlink_metadata\(\),\s*"src\s*=\s*\{\}",\s*src\.display\(\)\);\s*
        builder\.install\(&src,\s*&dst,\s*0o755\);
      #let src = std::path::PathBuf::from("/usr/bin/ld.lld");
       if std::fs::symlink_metadata(&src).is_ok() { builder.install(&src, &dst, 0o755) }#sx
    ' -i "$f"

    # also catch variants that don’t use the exact t! macro string
    perl -0777 -pe '
      s#
        let\s+src\s*=\s*[^;]*join\(\s*"rust-lld"\s*\)\s*;\s*
        [^\n]*src\.symlink_metadata\(\)[^\n]*\n
        [^\n]*builder\.install\(&src,\s*&dst,\s*0o755\);
      #let src = std::path::PathBuf::from("/usr/bin/ld.lld");
       if std::fs::symlink_metadata(&src).is_ok() { builder.install(&src, &dst, 0o755) }#sx
    ' -i "$f"
  done

  # prove patches landed
  grep -RIn '/usr/bin/ld\.lld' src/bootstrap/src || die "rust-lld patches not applied"

  # your existing musl tweaks etc
  if use elibc_musl; then
    eapply "${FILESDIR}"/rust/*.patch
    sed -i 's/base\.crt_static_default = true;/base\.crt_static_default = false;/g' \
      compiler/rustc_target/src/spec/base/linux_musl.rs || die
    sed -i 's/base\.crt_static_default = true;/base\.crt_static_default = false;/g' \
      compiler/rustc_target/src/spec/targets/x86_64_unknown_linux_musl.rs || die
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
      -j$(makeopts_jobs) \
    || die
  )
}

src_install() {
  rust_force_rust_lld

  (
    IFS=$'\n'
    DESTDIR="${D}" \
    "${EPYTHON}" ./x.py install -vv --config="${S}/config.toml" \
      -j$(makeopts_jobs) \
    || die
  )

  cleanup_install
  dedup_symlink "${ED}"
}
