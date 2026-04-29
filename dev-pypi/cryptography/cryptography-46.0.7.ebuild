# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/asn1-0.22.0
	rust-crates/asn1_derive-0.22.0
	rust-crates/autocfg-1.5.0
	rust-crates/base64-0.22.1
	rust-crates/bitflags-2.9.4
	rust-crates/cc-1.2.37
	rust-crates/cfg-if-1.0.3
	rust-crates/find-msvc-tools-0.1.1
	rust-crates/foreign-types-0.3.2
	rust-crates/foreign-types-shared-0.1.1
	rust-crates/heck-0.5.0
	rust-crates/indoc-2.0.6
	rust-crates/itoa-1.0.15
	rust-crates/libc-0.2.175
	rust-crates/memoffset-0.9.1
	rust-crates/once_cell-1.21.3
	rust-crates/openssl-0.10.74
	rust-crates/openssl-macros-0.1.1
	rust-crates/openssl-sys-0.9.110
	rust-crates/pem-3.0.5
	rust-crates/pkg-config-0.3.32
	rust-crates/portable-atomic-1.11.1
	rust-crates/proc-macro2-1.0.101
	rust-crates/pyo3-0.26.0
	rust-crates/pyo3-build-config-0.26.0
	rust-crates/pyo3-ffi-0.26.0
	rust-crates/pyo3-macros-0.26.0
	rust-crates/pyo3-macros-backend-0.26.0
	rust-crates/quote-1.0.40
	rust-crates/self_cell-1.2.0
	rust-crates/shlex-1.3.0
	rust-crates/syn-2.0.106
	rust-crates/target-lexicon-0.13.3
	rust-crates/unicode-ident-1.0.19
	rust-crates/unindent-0.2.4
	rust-crates/vcpkg-0.2.15
"
# lockstep-cargo-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit cargo lockstep-cargo distutils-r1 pypi

PYPI_PN="cryptography"
DESCRIPTION="cryptography is a package which provides cryptographic recipes and primitives to Python developers."
HOMEPAGE="https://github.com/pyca/cryptography"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cffi
"
# lockstep-pypi-deps: end
