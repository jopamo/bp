# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="core-foundation-sys"
CRATE_VERSION="0.8.7"
CRATE_CHECKSUM="773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to Core Foundation for macOS"
HOMEPAGE="https://github.com/servo/core-foundation-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"link"
	"mac_os_10_7_support"
	"mac_os_10_8_features"
)
