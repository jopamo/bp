# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="trybuild"
CRATE_VERSION="1.0.115"
CRATE_CHECKSUM="5f614c21bd3a61bad9501d75cbb7686f00386c806d7f456778432c25cf86948a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Test harness for ui tests of compiler diagnostics"
HOMEPAGE="https://github.com/dtolnay/trybuild"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"diff"
)
