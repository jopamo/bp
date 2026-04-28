# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="core-foundation-sys"
CRATE_VERSION="0.8.6"
CRATE_CHECKSUM="06ea2b9bc92be3c2baa9334a323ebca2d6f074ff852cd1d7b11064035cd3868f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to Core Foundation for macOS"
HOMEPAGE="https://github.com/servo/core-foundation-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"link"
	"mac_os_10_7_support"
	"mac_os_10_8_features"
)
