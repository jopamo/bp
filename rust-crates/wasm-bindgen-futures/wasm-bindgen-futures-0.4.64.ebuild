# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen-futures"
CRATE_VERSION="0.4.64"
CRATE_CHECKSUM="e9c5522b3a28661442748e09d40924dfb9ca614b21c00d3fd135720e48b67db8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bridging the gap between Rust Futures and JavaScript Promises"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"futures-core-03-stream"
	"std"
)
