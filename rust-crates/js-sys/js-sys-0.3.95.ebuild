# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="js-sys"
CRATE_VERSION="0.3.95"
CRATE_CHECKSUM="2964e92d1d9dc3364cae4d718d93f227e3abb088e747d92e0395bfdedf1c12ca"
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
	"futures"
	"futures-core-03-stream"
	"std"
	"unsafe-eval"
)
