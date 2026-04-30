# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen-shared"
CRATE_VERSION="0.2.118"
CRATE_CHECKSUM="5fd04d9e306f1907bd13c6361b5c6bfc7b3b3c095ed3f8a9246390f8dbdee129"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared support between wasm-bindgen and wasm-bindgen cli, an internal dependency."
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
