# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen-futures"
CRATE_VERSION="0.4.50"
CRATE_CHECKSUM="555d470ec0bc3bb57890405e5d4322cc9ea83cebb085523ced7be4144dac1e61"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bridging the gap between Rust Futures and JavaScript Promises"
HOMEPAGE="https://rustwasm.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"futures-core-03-stream"
	"std"
)
