# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde-wasm-bindgen"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="f3b143e2833c57ab9ad3ea280d21fd34e285a42837aeb0ee301f4f41890fa00e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Native Serde adapter for wasm-bindgen"
HOMEPAGE="https://github.com/cloudflare/serde-wasm-bindgen"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
