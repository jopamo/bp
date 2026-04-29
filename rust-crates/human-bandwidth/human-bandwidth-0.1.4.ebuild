# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="human-bandwidth"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="8a5afe042873d564e1fccc5d50983e1e6341ffcae8fb7603c6c542de7129a785"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for representing bandwidth speed in a human-readable format."
HOMEPAGE="https://github.com/stack-rs/human-bandwidth"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"binary-system"
	"display-integer"
	"serde"
)
