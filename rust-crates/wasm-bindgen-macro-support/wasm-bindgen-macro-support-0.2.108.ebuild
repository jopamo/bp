# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro-support"
CRATE_VERSION="0.2.108"
CRATE_CHECKSUM="5256bae2d58f54820e6490f9839c49780dff84c65aeab9e772f15d5f0e913a55"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation APIs for the \`#[wasm_bindgen]\` attribute"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"extra-traits"
	"strict-macro"
)
