# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="security-framework"
CRATE_VERSION="3.2.0"
CRATE_CHECKSUM="271720403f46ca04f7ba6f55d438f8bd878d6b8ca0a1046e8228c4145bcbb316"
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
	"nightly"
	"session-tickets"
	"sync-keychain"
)
