# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="wasm-streams"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="9d1ec4f6517c9e11ae630e200b2b65d193279042e28edd4a2cda233e46670bbb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bridging between web streams and Rust streams using WebAssembly"
HOMEPAGE="https://github.com/MattiasBuelens/wasm-streams/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
