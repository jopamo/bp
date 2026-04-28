# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="security-framework"
CRATE_VERSION="3.5.1"
CRATE_CHECKSUM="b3297343eaf830f66ede390ea39da1d462b6b0c1b000f420d0a83f898bbbe6ef"
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
