# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/ahash-0.8.12
	rust-crates/aho-corasick-1.1.4
	rust-crates/anes-0.1.6
	rust-crates/anstyle-1.0.14
	rust-crates/autocfg-1.5.1
	rust-crates/bit-set-0.8.0
	rust-crates/bit-vec-0.8.0
	rust-crates/bitflags-2.13.0
	rust-crates/bitvec-1.1.1
	rust-crates/bumpalo-3.20.3
	rust-crates/cast-0.3.0
	rust-crates/cfg-if-1.0.4
	rust-crates/ciborium-0.2.2
	rust-crates/ciborium-io-0.2.2
	rust-crates/ciborium-ll-0.2.2
	rust-crates/clap-4.6.1
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
	rust-crates/either-1.16.0
	rust-crates/equivalent-1.0.2
	rust-crates/errno-0.3.14
	rust-crates/fastrand-2.4.1
	rust-crates/fnv-1.0.7
	rust-crates/funty-2.0.0
	rust-crates/futures-core-0.3.32
	rust-crates/futures-task-0.3.32
	rust-crates/futures-util-0.3.32
	rust-crates/getrandom-0.3.4
	rust-crates/getrandom-0.4.3
	rust-crates/half-2.7.1
	rust-crates/hashbrown-0.17.1
	rust-crates/heck-0.5.0
	rust-crates/hermit-abi-0.5.2
	rust-crates/indexmap-2.14.0
	rust-crates/is-terminal-0.4.17
	rust-crates/itertools-0.10.5
	rust-crates/itoa-1.0.18
	rust-crates/js-sys-0.3.103
	rust-crates/lazy_static-1.5.0
	rust-crates/lexical-parse-float-1.0.6
	rust-crates/lexical-parse-integer-1.0.6
	rust-crates/lexical-util-1.0.7
	rust-crates/libc-0.2.186
	rust-crates/linux-raw-sys-0.12.1
	rust-crates/memchr-2.8.2
	rust-crates/num-bigint-0.4.6
	rust-crates/num-integer-0.1.46
	rust-crates/num-traits-0.2.19
	rust-crates/once_cell-1.21.4
	rust-crates/oorandom-11.1.5
	rust-crates/paste-1.0.15
	rust-crates/pin-project-lite-0.2.17
	rust-crates/plotters-0.3.7
	rust-crates/plotters-backend-0.3.7
	rust-crates/plotters-svg-0.3.7
	rust-crates/portable-atomic-1.13.1
	rust-crates/ppv-lite86-0.2.21
	rust-crates/proc-macro2-1.0.106
	rust-crates/proptest-1.11.0
	rust-crates/pyo3-0.29.0
	rust-crates/pyo3-build-config-0.29.0
	rust-crates/pyo3-ffi-0.29.0
	rust-crates/pyo3-macros-0.29.0
	rust-crates/pyo3-macros-backend-0.29.0
	rust-crates/quick-error-1.2.3
	rust-crates/quote-1.0.46
	rust-crates/r-efi-5.3.0
	rust-crates/r-efi-6.0.0
	rust-crates/radium-0.7.0
	rust-crates/rand-0.9.4
	rust-crates/rand_chacha-0.9.0
	rust-crates/rand_core-0.9.5
	rust-crates/rand_xorshift-0.4.0
	rust-crates/rayon-1.12.0
	rust-crates/rayon-core-1.13.0
	rust-crates/regex-1.12.4
	rust-crates/regex-automata-0.4.14
	rust-crates/regex-syntax-0.8.11
	rust-crates/rustix-1.1.4
	rust-crates/rustversion-1.0.22
	rust-crates/rusty-fork-0.3.1
	rust-crates/same-file-1.0.6
	rust-crates/serde-1.0.228
	rust-crates/serde_core-1.0.228
	rust-crates/serde_derive-1.0.228
	rust-crates/serde_json-1.0.150
	rust-crates/slab-0.4.12
	rust-crates/smallvec-1.15.2
	rust-crates/syn-2.0.118
	rust-crates/tap-1.0.1
	rust-crates/target-lexicon-0.13.5
	rust-crates/tempfile-3.27.0
	rust-crates/tinytemplate-1.2.1
	rust-crates/unarray-0.1.4
	rust-crates/unicode-ident-1.0.24
	rust-crates/uuid-1.23.4
	rust-crates/version_check-0.9.5
	rust-crates/wait-timeout-0.2.1
	rust-crates/walkdir-2.5.0
	rust-crates/wasip2-1.0.4+wasi-0.2.12
	rust-crates/wasm-bindgen-0.2.126
	rust-crates/wasm-bindgen-macro-0.2.126
	rust-crates/wasm-bindgen-macro-support-0.2.126
	rust-crates/wasm-bindgen-shared-0.2.126
	rust-crates/web-sys-0.3.103
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
	rust-crates/wit-bindgen-0.57.1
	rust-crates/wyz-0.5.1
	rust-crates/zerocopy-0.8.52
	rust-crates/zerocopy-derive-0.8.52
	rust-crates/zmij-1.0.21
"
# lockstep-cargo-deps: end
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit cargo lockstep-cargo distutils-r1

DESCRIPTION="Fast iterable JSON parser."
HOMEPAGE="https://github.com/pydantic/jiter/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1d/1f/10936e16d8860c70698a1aa939a46aa0224813b782bce4e000e637da0b2d/jiter-0.16.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jiter-0.16.0"

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
	dev-pypi/gpep517[${PYTHON_USEDEP}]
"
