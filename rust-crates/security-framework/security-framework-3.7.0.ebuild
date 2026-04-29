# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="security-framework"
CRATE_VERSION="3.7.0"
CRATE_CHECKSUM="b7f4bc775c73d9a02cde8bf7b2ec4c9d12743edf609006c7facc23998404cd1d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Security.framework bindings for macOS and iOS"
HOMEPAGE="https://lib.rs/crates/security_framework"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"OSX_10_12"
	"OSX_10_13"
	"OSX_10_14"
	"OSX_10_15"
	"alpn"
	"default"
	"job-bless"
	"macos-12"
	"nightly"
	"session-tickets"
	"sync-keychain"
)
