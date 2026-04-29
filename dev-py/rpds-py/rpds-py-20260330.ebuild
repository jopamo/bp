# Distributed under the terms of the GNU General Public License v2
# lockstep-cargo-managed: true
# lockstep-cargo-deps: begin
CARGO_DEPS="
	rust-crates/archery-1.2.2
	rust-crates/cc-1.2.48
	rust-crates/find-msvc-tools-0.1.5
	rust-crates/heck-0.5.0
	rust-crates/libc-0.2.177
	rust-crates/once_cell-1.21.3
	rust-crates/portable-atomic-1.11.1
	rust-crates/proc-macro2-1.0.103
	rust-crates/pyo3-0.28.2
	rust-crates/pyo3-build-config-0.28.2
	rust-crates/pyo3-ffi-0.28.2
	rust-crates/pyo3-macros-0.28.2
	rust-crates/pyo3-macros-backend-0.28.2
	rust-crates/python3-dll-a-0.2.14
	rust-crates/quote-1.0.42
	rust-crates/rpds-1.2.0
	rust-crates/shlex-1.3.0
	rust-crates/syn-2.0.111
	rust-crates/target-lexicon-0.13.3
	rust-crates/triomphe-0.1.15
	rust-crates/unicode-ident-1.0.22
"
# lockstep-cargo-deps: end
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin

inherit cargo lockstep-cargo distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="Python bindings to Rust's persistent data structures (rpds)"
HOMEPAGE="https://github.com/crate-py/rpds/"
SNAPSHOT=bacd1f164afcdf1fdaaf30d9135d1acd1a38f9f2
SRC_URI="https://github.com/crate-py/rpds/archive/${SNAPSHOT}.tar.gz -> rpds-py-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/rpds-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/rpds/rpds.*.so"

RESTRICT="test network-sandbox"

src_prepare() {
	cargo update
	sed -i '/^license-files = \["LICENSE"\]/d' pyproject.toml || die
	distutils-r1_src_prepare
}
