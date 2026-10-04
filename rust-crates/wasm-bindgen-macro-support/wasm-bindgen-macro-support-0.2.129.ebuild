# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen-macro-support"
CRATE_VERSION="0.2.129"
CRATE_CHECKSUM="6f501a8bc3719dba86ef8ae4728879c08001bea749eb1333ac5b91e040e2a6b7"
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
