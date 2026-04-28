# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="js-sys"
CRATE_VERSION="0.3.85"
CRATE_CHECKSUM="8c942ebf8e95485ca0d52d97da7c5a2c387d0e7f0ba4c35e93bfcaee045955b3"
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
