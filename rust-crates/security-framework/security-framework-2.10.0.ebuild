# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="security-framework"
CRATE_VERSION="2.10.0"
CRATE_CHECKSUM="770452e37cad93e0a50d5abc3990d2bc351c36d0328f86cefec2f2fb206eaef6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Security.framework bindings for macOS and iOS"
HOMEPAGE="https://lib.rs/crates/security_framework"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"OSX_10_10"
	"OSX_10_11"
	"OSX_10_12"
	"OSX_10_13"
	"OSX_10_14"
	"OSX_10_15"
	"OSX_10_9"
	"alpn"
	"default"
	"job-bless"
	"nightly"
	"serial-number-bigint"
	"session-tickets"
)
