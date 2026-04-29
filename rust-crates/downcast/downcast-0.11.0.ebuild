# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="downcast"
CRATE_VERSION="0.11.0"
CRATE_CHECKSUM="1435fa1053d8b2fbbe9be7e97eca7f33d37b28409959813daefc1446a14247f1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait for downcasting trait objects back to their original types."
HOMEPAGE="https://github.com/fkoep/downcast-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"std"
)
