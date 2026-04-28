# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="js-sys"
CRATE_VERSION="0.3.77"
CRATE_CHECKSUM="1cfaf33c695fc6e08064efbc1f72ec937429614f25eef83af942d0e227c3a28f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings for all JS global objects and functions in all JS environments like Node.js and browsers, built on `#[wasm_bindgen]` using the `wasm-bindgen` crate."
HOMEPAGE="https://rustwasm.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
