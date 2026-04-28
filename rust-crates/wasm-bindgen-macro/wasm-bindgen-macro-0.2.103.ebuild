# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro"
CRATE_VERSION="0.2.103"
CRATE_CHECKSUM="fc65f4f411d91494355917b605e1480033152658d71f722a90647f56a70c88a0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Definition of the \`#[wasm_bindgen]\` attribute, an internal dependency"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"strict-macro"
)
