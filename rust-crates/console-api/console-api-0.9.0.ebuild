# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="console-api"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="e8599749b6667e2f0c910c1d0dff6901163ff698a52d5a39720f61b5be4b20d3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Protobuf wire format bindings for the Tokio console."
HOMEPAGE="https://github.com/tokio-rs/console/blob/main/console-api"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"transport"
)
