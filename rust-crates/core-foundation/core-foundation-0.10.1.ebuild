# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="core-foundation"
CRATE_VERSION="0.10.1"
CRATE_CHECKSUM="b2a6cd9ae233e7f62ba4e9353e81a88df7fc8a5987b8d445b4d90c879bd156f6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to Core Foundation for macOS"
HOMEPAGE="https://github.com/servo/core-foundation-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"link"
	"mac_os_10_7_support"
	"mac_os_10_8_features"
	"with-uuid"
)
