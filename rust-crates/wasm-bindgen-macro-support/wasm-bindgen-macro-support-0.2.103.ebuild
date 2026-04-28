# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro-support"
CRATE_VERSION="0.2.103"
CRATE_CHECKSUM="ffc003a991398a8ee604a401e194b6b3a39677b3173d6e74495eb51b82e99a32"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The part of the implementation of the \`#[wasm_bindgen]\` attribute that is not in the shared backend crate"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"extra-traits"
	"strict-macro"
)
