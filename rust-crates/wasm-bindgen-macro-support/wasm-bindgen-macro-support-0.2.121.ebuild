# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen-macro-support"
CRATE_VERSION="0.2.121"
CRATE_CHECKSUM="d95a9ec35c64b2a7cb35d3fead40c4238d0940c86d107136999567a4703259f2"
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
