# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro-support"
CRATE_VERSION="0.2.117"
CRATE_CHECKSUM="dca9693ef2bab6d4e6707234500350d8dad079eb508dca05530c85dc3a529ff2"
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
