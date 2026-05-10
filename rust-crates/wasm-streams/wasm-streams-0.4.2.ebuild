# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wasm-streams"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="15053d8d85c7eccdbefef60f06769760a563c7f0a9d6902a13d35c7800b0ad65"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bridging between web streams and Rust streams using WebAssembly"
HOMEPAGE="https://github.com/MattiasBuelens/wasm-streams/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
