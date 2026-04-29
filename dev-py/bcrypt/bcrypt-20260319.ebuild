# Distributed under the terms of the GNU General Public License v2
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/anyhow-1.0.102
	rust-crates/base64-0.22.1
	rust-crates/bcrypt-0.19.0
	rust-crates/bcrypt-pbkdf-0.10.0
	rust-crates/bitflags-2.11.0
	rust-crates/block-buffer-0.10.4
	rust-crates/blowfish-0.9.1
	rust-crates/byteorder-1.5.0
	rust-crates/cfg-if-1.0.4
	rust-crates/cipher-0.4.4
	rust-crates/cpufeatures-0.2.17
	rust-crates/crypto-common-0.1.7
	rust-crates/digest-0.10.7
	rust-crates/equivalent-1.0.2
	rust-crates/foldhash-0.1.5
	rust-crates/generic-array-0.14.7
	rust-crates/getrandom-0.4.2
	rust-crates/hashbrown-0.15.5
	rust-crates/hashbrown-0.16.1
	rust-crates/heck-0.5.0
	rust-crates/id-arena-2.3.0
	rust-crates/indexmap-2.13.0
	rust-crates/inout-0.1.4
	rust-crates/itoa-1.0.18
	rust-crates/leb128fmt-0.1.0
	rust-crates/libc-0.2.183
	rust-crates/log-0.4.29
	rust-crates/memchr-2.8.0
	rust-crates/once_cell-1.21.4
	rust-crates/pbkdf2-0.12.2
	rust-crates/portable-atomic-1.13.1
	rust-crates/prettyplease-0.2.37
	rust-crates/proc-macro2-1.0.106
	rust-crates/pyo3-0.28.2
	rust-crates/pyo3-build-config-0.28.2
	rust-crates/pyo3-ffi-0.28.2
	rust-crates/pyo3-macros-0.28.2
	rust-crates/pyo3-macros-backend-0.28.2
	rust-crates/quote-1.0.45
	rust-crates/r-efi-6.0.0
	rust-crates/semver-1.0.27
	rust-crates/serde-1.0.228
	rust-crates/serde_core-1.0.228
	rust-crates/serde_derive-1.0.228
	rust-crates/serde_json-1.0.149
	rust-crates/sha2-0.10.9
	rust-crates/subtle-2.6.1
	rust-crates/syn-2.0.117
	rust-crates/target-lexicon-0.13.5
	rust-crates/typenum-1.19.0
	rust-crates/unicode-ident-1.0.24
	rust-crates/unicode-xid-0.2.6
	rust-crates/version_check-0.9.5
	rust-crates/wasip2-1.0.1+wasi-0.2.4
	rust-crates/wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06
	rust-crates/wasm-encoder-0.244.0
	rust-crates/wasm-metadata-0.244.0
	rust-crates/wasmparser-0.244.0
	rust-crates/wit-bindgen-0.46.0
	rust-crates/wit-bindgen-0.51.0
	rust-crates/wit-bindgen-core-0.51.0
	rust-crates/wit-bindgen-rust-0.51.0
	rust-crates/wit-bindgen-rust-macro-0.51.0
	rust-crates/wit-component-0.244.0
	rust-crates/wit-parser-0.244.0
	rust-crates/zeroize-1.8.2
	rust-crates/zmij-1.0.21
"
# lockstep-cargo-deps: end
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit cargo lockstep-cargo distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="Modern password hashing for software and servers"
HOMEPAGE="https://pypi.org/project/bcrypt/"
SNAPSHOT=3191062a810ffb79aa48810f92371b1345bfa3b1
SRC_URI="https://github.com/pyca/bcrypt/archive/${SNAPSHOT}.tar.gz -> bcrypt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/bcrypt-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

BDEPEND=">=dev-py/setuptools-rust-1.7.0[${PYTHON_USEDEP}]"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/bcrypt/_bcrypt.*.so"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
}

python_configure_all() {
	export RUSTFLAGS="${RUSTFLAGS} --cfg pyo3_unsafe_allow_subinterpreters"
	export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=clang
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest tests
}
