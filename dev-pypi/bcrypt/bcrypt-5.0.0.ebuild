# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/autocfg-1.5.0
	rust-crates/base64-0.22.1
	rust-crates/bcrypt-0.17.1
	rust-crates/bcrypt-pbkdf-0.10.0
	rust-crates/block-buffer-0.10.4
	rust-crates/blowfish-0.9.1
	rust-crates/byteorder-1.5.0
	rust-crates/cfg-if-1.0.3
	rust-crates/cipher-0.4.4
	rust-crates/cpufeatures-0.2.17
	rust-crates/crypto-common-0.1.6
	rust-crates/digest-0.10.7
	rust-crates/generic-array-0.14.7
	rust-crates/getrandom-0.3.3
	rust-crates/heck-0.5.0
	rust-crates/indoc-2.0.6
	rust-crates/inout-0.1.4
	rust-crates/libc-0.2.176
	rust-crates/memoffset-0.9.1
	rust-crates/once_cell-1.21.3
	rust-crates/pbkdf2-0.12.2
	rust-crates/portable-atomic-1.11.1
	rust-crates/proc-macro2-1.0.101
	rust-crates/pyo3-0.26.0
	rust-crates/pyo3-build-config-0.26.0
	rust-crates/pyo3-ffi-0.26.0
	rust-crates/pyo3-macros-0.26.0
	rust-crates/pyo3-macros-backend-0.26.0
	rust-crates/quote-1.0.40
	rust-crates/r-efi-5.3.0
	rust-crates/sha2-0.10.9
	rust-crates/subtle-2.6.1
	rust-crates/syn-2.0.106
	rust-crates/target-lexicon-0.13.3
	rust-crates/typenum-1.18.0
	rust-crates/unicode-ident-1.0.19
	rust-crates/unindent-0.2.4
	rust-crates/version_check-0.9.5
	rust-crates/wasi-0.14.7+wasi-0.2.4
	rust-crates/wasip2-1.0.1+wasi-0.2.4
	rust-crates/wit-bindgen-0.46.0
	rust-crates/zeroize-1.8.1
"
# lockstep-cargo-deps: end
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit cargo lockstep-cargo distutils-r1 pypi

PYPI_PN="bcrypt"
DESCRIPTION="Modern password hashing for your software and your servers"
HOMEPAGE="https://github.com/pyca/bcrypt/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	dev-py/setuptools-rust[${PYTHON_USEDEP}]
"
