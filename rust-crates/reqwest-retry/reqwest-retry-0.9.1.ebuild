# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="reqwest-retry"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="fe2412db2af7d2268e7a5406be0431f37d9eb67ff390f35b395716f5f06c2eaa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Retry middleware for reqwest."
HOMEPAGE="https://github.com/TrueLayer/reqwest-middleware"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"tracing"
)
