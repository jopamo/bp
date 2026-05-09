# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic multiprocessing python-any-r1

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"
SRC_URI="https://static.rust-lang.org/dist/rustc-${PV}-src.tar.xz"
S="${WORKDIR}/rustc-${PV}-src"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	${PYTHON_DEPS}
	app-build/llvm
	app-dev/cmake
	virtual/rust
"

ABI_VER="$(ver_cut 1-2)"

CMAKE_WARN_UNUSED_CLI=no

RESTRICT="test"

QA_FLAGS_IGNORED="
	usr/lib/${PN}/${PV}/bin/.*
	usr/libexec/.*
	usr/lib/lib.*.so
	usr/lib/rustlib/.*/bin/.*
	usr/lib/rustlib/.*/lib/lib.*.so
"

QA_SONAME="
	usr/lib/lib.*.so.*
	usr/lib/rustlib/.*/lib/lib.*.so
"

RUST_SYSTEM_LLD=/usr/bin/ld.lld
RUST_SYSTEM_RUSTC="${EPREFIX}/usr/bin/rustc"
RUST_SYSTEM_CARGO="${EPREFIX}/usr/bin/cargo"
RUST_BOOTSTRAP_ROOT="${EPREFIX}/opt/rust"

rust_select_bootstrap() {
	if [[ -x ${RUST_SYSTEM_RUSTC} ]]; then
		[[ -x ${RUST_SYSTEM_CARGO} ]] || die "found ${RUST_SYSTEM_RUSTC} but missing ${RUST_SYSTEM_CARGO}"

		RUST_BOOTSTRAP_RUSTC="${RUST_SYSTEM_RUSTC}"
		RUST_BOOTSTRAP_CARGO="${RUST_SYSTEM_CARGO}"
		RUST_BOOTSTRAP_BINDIR="${EPREFIX}/usr/bin"
	else
		[[ -x ${RUST_BOOTSTRAP_ROOT}/bin/rustc ]] || die "missing bootstrap rustc: ${RUST_BOOTSTRAP_ROOT}/bin/rustc"
		[[ -x ${RUST_BOOTSTRAP_ROOT}/bin/cargo ]] || die "missing bootstrap cargo: ${RUST_BOOTSTRAP_ROOT}/bin/cargo"

		RUST_BOOTSTRAP_RUSTC="${RUST_BOOTSTRAP_ROOT}/bin/rustc"
		RUST_BOOTSTRAP_CARGO="${RUST_BOOTSTRAP_ROOT}/bin/cargo"
		RUST_BOOTSTRAP_BINDIR="${RUST_BOOTSTRAP_ROOT}/bin"
	fi

	export RUST_BOOTSTRAP_RUSTC
	export RUST_BOOTSTRAP_CARGO
	export RUST_BOOTSTRAP_BINDIR
}

rust_force_rust_lld() {
	local TRIPLE="$(usex arm64 aarch64-unknown-linux-$(usex elibc_musl musl gnu) x86_64-unknown-linux-$(usex elibc_musl musl gnu))"

	[[ -x ${RUST_SYSTEM_LLD} ]] || die "${RUST_SYSTEM_LLD} not found, emerge sys-devel/lld"

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
	rust_select_bootstrap

	einfo "using bootstrap rustc: ${RUST_BOOTSTRAP_RUSTC}"
	einfo "using bootstrap cargo: ${RUST_BOOTSTRAP_CARGO}"

	export AR=llvm-ar
	export RANLIB=llvm-ranlib
	export NM=llvm-nm
	export LIBGIT2_NO_PKG_CONFIG=1
	export LLVM_LINK_SHARED=1
	export PATH="${RUST_BOOTSTRAP_BINDIR}:${PATH}"
	export RUSTFLAGS="${RUSTFLAGS} -Clinker-features=-lld -Lnative=$("/usr/bin/llvm-config" --libdir)"
	export CARGO_HTTP_CAINFO=/etc/ssl/certs/ca-certificates.crt
	export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
}

src_prepare() {
	"${EPYTHON}" - <<'PY' || die
from pathlib import Path

def replace_once(path: Path, old: str, new: str) -> None:
    data = path.read_text()
    if new in data:
        return
    if old not in data:
        raise SystemExit(f"{path}: expected source snippet not found")
    path.write_text(data.replace(old, new, 1))

replace_once(
    Path("compiler/rustc_target/src/lib.rs"),
    """    match option_env!("CFG_LIBDIR_RELATIVE") {\n        None | Some("lib") => {\n            if sysroot.join(PRIMARY_LIB_DIR).join(RUST_LIB_DIR).exists() {\n                PRIMARY_LIB_DIR.into()\n            } else {\n                SECONDARY_LIB_DIR.into()\n            }\n        }\n        Some(libdir) => libdir.into(),\n    }\n""",
    """    match option_env!("CFG_LIBDIR_RELATIVE") {\n        Some(libdir) if libdir != "lib" => libdir.into(),\n        _ => {\n            let primary = sysroot.join(PRIMARY_LIB_DIR);\n            let secondary = sysroot.join(SECONDARY_LIB_DIR);\n\n            if primary.join(RUST_LIB_DIR).exists() {\n                match (primary.canonicalize(), secondary.canonicalize()) {\n                    (Ok(primary_real), Ok(secondary_real)) if primary_real == secondary_real => {\n                        SECONDARY_LIB_DIR.into()\n                    }\n                    _ => PRIMARY_LIB_DIR.into(),\n                }\n            } else {\n                SECONDARY_LIB_DIR.into()\n            }\n        }\n    }\n""",
)

replace_once(
    Path("src/bootstrap/src/core/build_steps/compile.rs"),
    """            let stage0_lib_dir = builder.out.join(host).join("stage0/lib");\n            t!(fs::create_dir_all(sysroot.join("lib")));\n            builder.cp_link_r(&stage0_lib_dir, &sysroot.join("lib"));\n\n            // Copy codegen-backends from stage0\n            let sysroot_codegen_backends = builder.sysroot_codegen_backends(compiler);\n            t!(fs::create_dir_all(&sysroot_codegen_backends));\n            let stage0_codegen_backends = builder\n                .out\n                .join(host)\n                .join("stage0/lib/rustlib")\n                .join(host)\n                .join("codegen-backends");\n""",
    """            let stage0_libdir = &builder.build.initial_relative_libdir;\n            let stage0_lib_dir = builder.out.join(host).join("stage0").join(stage0_libdir);\n            t!(fs::create_dir_all(sysroot.join(stage0_libdir)));\n            builder.cp_link_r(&stage0_lib_dir, &sysroot.join(stage0_libdir));\n\n            // Copy codegen-backends from stage0\n            let sysroot_codegen_backends = builder.sysroot_codegen_backends(compiler);\n            t!(fs::create_dir_all(&sysroot_codegen_backends));\n            let stage0_codegen_backends = stage0_lib_dir\n                .join("rustlib")\n                .join(host)\n                .join("codegen-backends");\n""",
)

replace_once(
    Path("src/bootstrap/src/core/build_steps/compile.rs"),
    """            if builder.local_rebuild {\n                // On local rebuilds this path might be a symlink to the project root,\n                // which can be read-only (e.g., on CI). So remove it before copying\n                // the stage0 lib.\n                let _ = fs::remove_dir_all(sysroot.join("lib/rustlib/src/rust"));\n            }\n\n            builder.cp_link_r(&builder.initial_sysroot.join("lib"), &sysroot.join("lib"));\n""",
    """            let stage0_libdir = &builder.build.initial_relative_libdir;\n\n            if builder.local_rebuild {\n                // On local rebuilds this path might be a symlink to the project root,\n                // which can be read-only (e.g., on CI). So remove it before copying\n                // the stage0 lib.\n                let _ = fs::remove_dir_all(sysroot.join(stage0_libdir).join("rustlib/src/rust"));\n            }\n\n            builder.cp_link_r(\n                &builder.initial_sysroot.join(stage0_libdir),\n                &sysroot.join(stage0_libdir),\n            );\n""",
)
PY

	if use elibc_musl; then
		if compgen -G "${FILESDIR}/rust/*.patch" > /dev/null; then
			eapply "${FILESDIR}"/rust/*.patch
		fi
		sed -i 's/base\.crt_static_default = true;/base\.crt_static_default = false;/g' \
			compiler/rustc_target/src/spec/base/linux_musl.rs || die
		sed -i 's/base\.crt_static_default = true;/base\.crt_static_default = false;/g' \
			compiler/rustc_target/src/spec/targets/x86_64_unknown_linux_musl.rs || die
		sed -i 's/^\([[:space:]]*\)extern "C" *{$/\1unsafe extern "C" {/' \
			library/unwind/src/lib.rs || die
		sed -i 's/base\.crt_static_default = true;/base\.crt_static_default = false;/g' \
			compiler/rustc_target/src/spec/targets/aarch64_unknown_linux_musl.rs || die
	fi

	filter-clang
	filter-lto
	default
}

src_configure() {
	rust_select_bootstrap

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
		cargo = "${RUST_BOOTSTRAP_CARGO}"
		rustc = "${RUST_BOOTSTRAP_RUSTC}"
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
			--stage 2 compiler/rustc library src/tools/cargo src/tools/clippy \
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
}
