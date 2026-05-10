# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="assert_cmd"
CRATE_VERSION="2.1.2"
CRATE_CHECKSUM="9c5bcfa8749ac45dd12cb11055aeeb6b27a3895560d60d71e3c23bf979e60514"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Test CLI Applications."
HOMEPAGE="https://github.com/assert-rs/assert_cmd"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"color"
	"color-auto"
)
