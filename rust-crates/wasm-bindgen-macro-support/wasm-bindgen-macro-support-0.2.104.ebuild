# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro-support"
CRATE_VERSION="0.2.104"
CRATE_CHECKSUM="9f07d2f20d4da7b26400c9f4a0511e6e0345b040694e8a75bd41d578fa4421d7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The part of the implementation of the \`#[wasm_bindgen]\` attribute that is not in the shared backend crate"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"extra-traits"
	"strict-macro"
)
