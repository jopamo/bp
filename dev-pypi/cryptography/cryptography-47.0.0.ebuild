# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/asn1-0.24.1
	rust-crates/asn1_derive-0.24.1
	rust-crates/base64-0.22.1
	rust-crates/bitflags-2.11.1
	rust-crates/cc-1.2.60
	rust-crates/cfg-if-1.0.4
	rust-crates/find-msvc-tools-0.1.9
	rust-crates/foreign-types-0.3.2
	rust-crates/foreign-types-shared-0.1.1
	rust-crates/heck-0.5.0
	rust-crates/itoa-1.0.18
	rust-crates/libc-0.2.186
	rust-crates/once_cell-1.21.4
	rust-crates/openssl-0.10.78
	rust-crates/openssl-macros-0.1.1
	rust-crates/openssl-sys-0.9.114
	rust-crates/pem-3.0.6
	rust-crates/pkg-config-0.3.33
	rust-crates/portable-atomic-1.13.1
	rust-crates/proc-macro2-1.0.106
	rust-crates/pyo3-0.28.3
	rust-crates/pyo3-build-config-0.28.3
	rust-crates/pyo3-ffi-0.28.3
	rust-crates/pyo3-macros-0.28.3
	rust-crates/pyo3-macros-backend-0.28.3
	rust-crates/quote-1.0.45
	rust-crates/self_cell-1.2.2
	rust-crates/shlex-1.3.0
	rust-crates/syn-2.0.117
	rust-crates/target-lexicon-0.13.5
	rust-crates/unicode-ident-1.0.24
	rust-crates/vcpkg-0.2.15
"
# lockstep-cargo-deps: end
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

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
