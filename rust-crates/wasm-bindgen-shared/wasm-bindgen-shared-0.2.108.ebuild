# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-shared"
CRATE_VERSION="0.2.108"
CRATE_CHECKSUM="1f01b580c9ac74c8d8f0c0e4afb04eeef2acf145458e52c03845ee9cd23e3d12"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared support between wasm-bindgen and wasm-bindgen cli, an internal dependency."
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
