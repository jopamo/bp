# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/cfg-if-1.0.4
	rust-crates/crunchy-0.2.4
	rust-crates/getrandom-0.3.4
	rust-crates/half-2.7.1
	rust-crates/heck-0.5.0
	rust-crates/libc-0.2.186
	rust-crates/once_cell-1.21.4
	rust-crates/portable-atomic-1.13.1
	rust-crates/ppv-lite86-0.2.21
	rust-crates/proc-macro2-1.0.106
	rust-crates/pyo3-0.29.2
	rust-crates/pyo3-build-config-0.29.2
	rust-crates/pyo3-ffi-0.29.2
	rust-crates/pyo3-macros-0.29.2
	rust-crates/pyo3-macros-backend-0.29.2
	rust-crates/quote-1.0.46
	rust-crates/r-efi-5.3.0
	rust-crates/rand-0.9.4
	rust-crates/rand_chacha-0.9.0
	rust-crates/rand_core-0.9.5
	rust-crates/syn-2.0.118
	rust-crates/target-lexicon-0.13.5
	rust-crates/unicode-ident-1.0.24
	rust-crates/wasip2-1.0.4+wasi-0.2.12
	rust-crates/wit-bindgen-0.57.1
	rust-crates/zerocopy-0.8.53
	rust-crates/zerocopy-derive-0.8.53
"
# lockstep-cargo-deps: end
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit cargo lockstep-cargo distutils-r1

DESCRIPTION="The property-based testing library for Python"
HOMEPAGE="https://hypothesis.works"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/18/7a/7a277ac07776191be594f74f6425649d529e4876f7d3ff1ee96d393ffdbc/hypothesis-6.165.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hypothesis-6.165.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/sortedcontainers
"
# lockstep-pypi-deps: end

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
	dev-pypi/gpep517[${PYTHON_USEDEP}]
"
