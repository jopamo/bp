# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/allocator-api2-0.2.21
	rust-crates/autocfg-1.5.0
	rust-crates/equivalent-1.0.2
	rust-crates/foldhash-0.2.0
	rust-crates/hashbrown-0.16.0
	rust-crates/heck-0.5.0
	rust-crates/indoc-2.0.7
	rust-crates/itoa-1.0.15
	rust-crates/libc-0.2.177
	rust-crates/memchr-2.7.6
	rust-crates/memmap2-0.9.9
	rust-crates/memoffset-0.9.1
	rust-crates/once_cell-1.21.3
	rust-crates/portable-atomic-1.11.1
	rust-crates/proc-macro2-1.0.103
	rust-crates/pyo3-0.25.1
	rust-crates/pyo3-build-config-0.25.1
	rust-crates/pyo3-ffi-0.25.1
	rust-crates/pyo3-macros-0.25.1
	rust-crates/pyo3-macros-backend-0.25.1
	rust-crates/quote-1.0.42
	rust-crates/rustversion-1.0.22
	rust-crates/ryu-1.0.20
	rust-crates/serde-1.0.228
	rust-crates/serde_core-1.0.228
	rust-crates/serde_derive-1.0.228
	rust-crates/serde_json-1.0.145
	rust-crates/syn-2.0.110
	rust-crates/target-lexicon-0.13.3
	rust-crates/unicode-ident-1.0.22
	rust-crates/unindent-0.2.4
"
# lockstep-cargo-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit cargo lockstep-cargo distutils-r1 pypi

PYPI_PN="safetensors"
DESCRIPTION="Lockstep-managed PyPI dependency safetensors"
HOMEPAGE="https://github.com/huggingface/safetensors"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
