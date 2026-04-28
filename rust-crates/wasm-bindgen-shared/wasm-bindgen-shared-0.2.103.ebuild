# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-shared"
CRATE_VERSION="0.2.103"
CRATE_CHECKSUM="293c37f4efa430ca14db3721dfbe48d8c33308096bd44d80ebaa775ab71ba1cf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared support between wasm-bindgen and wasm-bindgen cli, an internal dependency."
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
