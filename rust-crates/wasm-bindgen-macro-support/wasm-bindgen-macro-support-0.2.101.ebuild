# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro-support"
CRATE_VERSION="0.2.101"
CRATE_CHECKSUM="7bb4ce89b08211f923caf51d527662b75bdc9c9c7aab40f86dcb9fb85ac552aa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The part of the implementation of the `#[wasm_bindgen]` attribute that is not in the shared backend crate"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"extra-traits"
	"strict-macro"
)
