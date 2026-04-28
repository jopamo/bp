# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="web-time"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="5a6580f308b1fad9207618087a65c04e7a10bc77e02c8e84e9b00dd4b12fa0bb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Drop-in replacement for std::time for Wasm in browsers"
HOMEPAGE="https://github.com/daxpedda/web-time"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)
