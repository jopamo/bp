# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/archery-1.2.2
	rust-crates/autocfg-1.5.0
	rust-crates/cc-1.2.48
	rust-crates/find-msvc-tools-0.1.5
	rust-crates/heck-0.5.0
	rust-crates/indoc-2.0.7
	rust-crates/libc-0.2.177
	rust-crates/memoffset-0.9.1
	rust-crates/once_cell-1.21.3
	rust-crates/portable-atomic-1.11.1
	rust-crates/proc-macro2-1.0.103
	rust-crates/pyo3-0.27.2
	rust-crates/pyo3-build-config-0.27.2
	rust-crates/pyo3-ffi-0.27.2
	rust-crates/pyo3-macros-0.27.2
	rust-crates/pyo3-macros-backend-0.27.2
	rust-crates/python3-dll-a-0.2.14
	rust-crates/quote-1.0.42
	rust-crates/rpds-1.2.0
	rust-crates/rustversion-1.0.22
	rust-crates/shlex-1.3.0
	rust-crates/syn-2.0.111
	rust-crates/target-lexicon-0.13.3
	rust-crates/triomphe-0.1.15
	rust-crates/unicode-ident-1.0.22
	rust-crates/unindent-0.2.4
"
# lockstep-cargo-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit cargo lockstep-cargo distutils-r1 pypi

PYPI_PN="rpds-py"
DESCRIPTION="Python bindings to Rust's persistent data structures (rpds)"
HOMEPAGE="https://github.com/crate-py/rpds"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
