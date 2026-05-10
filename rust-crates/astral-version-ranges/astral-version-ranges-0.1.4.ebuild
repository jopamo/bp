# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral-version-ranges"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="31979bc305610246d78ac01d63467a12d8454c6e3b8b22b5811d343a1198dfbb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Performance-optimized type for generic version ranges and operations on them."
HOMEPAGE="https://github.com/astral-sh/pubgrub"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)
