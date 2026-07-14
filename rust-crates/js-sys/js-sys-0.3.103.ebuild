# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="js-sys"
CRATE_VERSION="0.3.103"
CRATE_CHECKSUM="53b44bfcdb3f8d5837a46dae1ca9660a837176eee74a28b229bc626816589102"
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
	"futures-core-03-stream"
	"std"
	"unsafe-eval"
)
