# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-backend"
CRATE_VERSION="0.2.101"
CRATE_CHECKSUM="e28d1ba982ca7923fd01448d5c30c6864d0a14109560296a162f80f305fb93bb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Backend code generation of the wasm-bindgen tool"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"extra-traits"
)
