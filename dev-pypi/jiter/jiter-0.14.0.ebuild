# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/ahash-0.8.12
	rust-crates/aho-corasick-1.1.4
	rust-crates/anes-0.1.6
	rust-crates/anstyle-1.0.14
	rust-crates/anyhow-1.0.102
	rust-crates/autocfg-1.5.0
	rust-crates/bitflags-2.11.0
	rust-crates/bitvec-1.0.1
	rust-crates/bumpalo-3.20.2
	rust-crates/cast-0.3.0
	rust-crates/cc-1.2.60
	rust-crates/cfg-if-1.0.4
	rust-crates/ciborium-0.2.2
	rust-crates/ciborium-io-0.2.2
	rust-crates/ciborium-ll-0.2.2
	rust-crates/clap-4.6.0
	rust-crates/clap_builder-4.6.0
	rust-crates/clap_lex-1.1.0
	rust-crates/codspeed-2.10.1
	rust-crates/codspeed-criterion-compat-2.10.1
	rust-crates/codspeed-criterion-compat-walltime-2.10.1
	rust-crates/colored-2.2.0
	rust-crates/criterion-plot-0.5.0
	rust-crates/crossbeam-deque-0.8.6
	rust-crates/crossbeam-epoch-0.9.18
	rust-crates/crossbeam-utils-0.8.21
	rust-crates/crunchy-0.2.4
	rust-crates/either-1.15.0
	rust-crates/equivalent-1.0.2
	rust-crates/find-msvc-tools-0.1.9
	rust-crates/foldhash-0.1.5
	rust-crates/funty-2.0.0
	rust-crates/getrandom-0.3.4
	rust-crates/getrandom-0.4.2
	rust-crates/half-2.7.1
	rust-crates/hashbrown-0.15.5
	rust-crates/hashbrown-0.17.0
	rust-crates/heck-0.5.0
	rust-crates/hermit-abi-0.5.2
	rust-crates/id-arena-2.3.0
	rust-crates/indexmap-2.14.0
	rust-crates/is-terminal-0.4.17
	rust-crates/itertools-0.10.5
	rust-crates/itoa-1.0.18
	rust-crates/js-sys-0.3.94
	rust-crates/lazy_static-1.5.0
	rust-crates/leb128fmt-0.1.0
	rust-crates/lexical-parse-float-1.0.6
	rust-crates/lexical-parse-integer-1.0.6
	rust-crates/lexical-util-1.0.7
	rust-crates/libc-0.2.184
	rust-crates/log-0.4.29
	rust-crates/memchr-2.8.0
	rust-crates/num-bigint-0.4.6
	rust-crates/num-integer-0.1.46
	rust-crates/num-traits-0.2.19
	rust-crates/once_cell-1.21.4
	rust-crates/oorandom-11.1.5
	rust-crates/paste-1.0.15
	rust-crates/plotters-0.3.7
	rust-crates/plotters-backend-0.3.7
	rust-crates/plotters-svg-0.3.7
	rust-crates/portable-atomic-1.13.1
	rust-crates/prettyplease-0.2.37
	rust-crates/proc-macro2-1.0.106
	rust-crates/pyo3-0.28.3
	rust-crates/pyo3-build-config-0.28.3
	rust-crates/pyo3-ffi-0.28.3
	rust-crates/pyo3-macros-0.28.3
	rust-crates/pyo3-macros-backend-0.28.3
	rust-crates/python3-dll-a-0.2.15
	rust-crates/quote-1.0.45
	rust-crates/r-efi-5.3.0
	rust-crates/r-efi-6.0.0
	rust-crates/radium-0.7.0
	rust-crates/rayon-1.11.0
	rust-crates/rayon-core-1.13.0
	rust-crates/regex-1.12.3
	rust-crates/regex-automata-0.4.14
	rust-crates/regex-syntax-0.8.10
	rust-crates/rustversion-1.0.22
	rust-crates/same-file-1.0.6
	rust-crates/semver-1.0.28
	rust-crates/serde-1.0.228
	rust-crates/serde_core-1.0.228
	rust-crates/serde_derive-1.0.228
	rust-crates/serde_json-1.0.149
	rust-crates/shlex-1.3.0
	rust-crates/smallvec-1.15.1
	rust-crates/syn-2.0.117
	rust-crates/tap-1.0.1
	rust-crates/target-lexicon-0.13.5
	rust-crates/tinytemplate-1.2.1
	rust-crates/unicode-ident-1.0.24
	rust-crates/unicode-xid-0.2.6
	rust-crates/uuid-1.23.0
	rust-crates/version_check-0.9.5
	rust-crates/walkdir-2.5.0
	rust-crates/wasip2-1.0.2+wasi-0.2.9
	rust-crates/wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06
	rust-crates/wasm-bindgen-0.2.117
	rust-crates/wasm-bindgen-macro-0.2.117
	rust-crates/wasm-bindgen-macro-support-0.2.117
	rust-crates/wasm-bindgen-shared-0.2.117
	rust-crates/wasm-encoder-0.244.0
	rust-crates/wasm-metadata-0.244.0
	rust-crates/wasmparser-0.244.0
	rust-crates/web-sys-0.3.94
	rust-crates/winapi-util-0.1.11
	rust-crates/windows-link-0.2.1
	rust-crates/windows-sys-0.59.0
	rust-crates/windows-sys-0.61.2
	rust-crates/windows-targets-0.52.6
	rust-crates/windows_aarch64_gnullvm-0.52.6
	rust-crates/windows_aarch64_msvc-0.52.6
	rust-crates/windows_i686_gnu-0.52.6
	rust-crates/windows_i686_gnullvm-0.52.6
	rust-crates/windows_i686_msvc-0.52.6
	rust-crates/windows_x86_64_gnu-0.52.6
	rust-crates/windows_x86_64_gnullvm-0.52.6
	rust-crates/windows_x86_64_msvc-0.52.6
	rust-crates/wit-bindgen-0.51.0
	rust-crates/wit-bindgen-core-0.51.0
	rust-crates/wit-bindgen-rust-0.51.0
	rust-crates/wit-bindgen-rust-macro-0.51.0
	rust-crates/wit-component-0.244.0
	rust-crates/wit-parser-0.244.0
	rust-crates/wyz-0.5.1
	rust-crates/zerocopy-0.8.48
	rust-crates/zerocopy-derive-0.8.48
	rust-crates/zmij-1.0.21
"
# lockstep-cargo-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit cargo lockstep-cargo distutils-r1 pypi

PYPI_PN="jiter"
DESCRIPTION="Fast iterable JSON parser."
HOMEPAGE="https://github.com/pydantic/jiter/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
