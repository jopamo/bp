# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="js-sys"
CRATE_VERSION="0.3.80"
CRATE_CHECKSUM="852f13bec5eba4ba9afbeb93fd7c13fe56147f055939ae21c43a29a0ecb2702e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings for all JS global objects and functions in all JS environments like Node.js and browsers, built on \`#[wasm_bindgen]\` using the \`wasm-bindgen\` crate."
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
