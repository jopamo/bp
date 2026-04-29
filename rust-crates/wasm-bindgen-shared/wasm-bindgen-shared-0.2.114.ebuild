# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen-shared"
CRATE_VERSION="0.2.114"
CRATE_CHECKSUM="75a326b8c223ee17883a4251907455a2431acc2791c98c26279376490c378c16"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared support between wasm-bindgen and wasm-bindgen cli, an internal dependency."
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
