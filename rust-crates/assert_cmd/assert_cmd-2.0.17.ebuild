# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="assert_cmd"
CRATE_VERSION="2.0.17"
CRATE_CHECKSUM="2bd389a4b2970a01282ee455294913c0a43724daedcd1a24c3eb0ec1c1320b66"
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
