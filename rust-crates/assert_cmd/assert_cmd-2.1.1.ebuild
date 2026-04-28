# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="assert_cmd"
CRATE_VERSION="2.1.1"
CRATE_CHECKSUM="bcbb6924530aa9e0432442af08bbcafdad182db80d2e560da42a6d442535bf85"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Test CLI Applications."
HOMEPAGE="https://github.com/assert-rs/assert_cmd"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"color"
	"color-auto"
)
