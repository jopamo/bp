# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-shared"
CRATE_VERSION="0.2.117"
CRATE_CHECKSUM="39129a682a6d2d841b6c429d0c51e5cb0ed1a03829d8b3d1e69a011e62cb3d3b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared support between wasm-bindgen and wasm-bindgen cli, an internal dependency."
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
