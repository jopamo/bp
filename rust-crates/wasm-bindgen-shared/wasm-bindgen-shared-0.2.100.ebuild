# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-shared"
CRATE_VERSION="0.2.100"
CRATE_CHECKSUM="1a05d73b933a847d6cccdda8f838a22ff101ad9bf93e33684f39c1f5f0eece3d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared support between wasm-bindgen and wasm-bindgen cli, an internal dependency."
HOMEPAGE="https://rustwasm.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
