# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="getrandom"
CRATE_VERSION="0.3.4"
CRATE_CHECKSUM="899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A small cross-platform library for retrieving random data from system source"
HOMEPAGE="https://github.com/rust-random/getrandom"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
	"wasm_js"
)
