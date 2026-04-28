# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-shared"
CRATE_VERSION="0.2.105"
CRATE_CHECKSUM="76f218a38c84bcb33c25ec7059b07847d465ce0e0a76b995e134a45adcb6af76"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared support between wasm-bindgen and wasm-bindgen cli, an internal dependency."
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
