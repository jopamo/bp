# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="security-framework"
CRATE_VERSION="3.3.0"
CRATE_CHECKSUM="80fb1d92c5028aa318b4b8bd7302a5bfcf48be96a37fc6fc790f806b0004ee0c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Security.framework bindings for macOS and iOS"
HOMEPAGE="https://lib.rs/crates/security_framework"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
