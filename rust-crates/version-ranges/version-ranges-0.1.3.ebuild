# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="version-ranges"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="31e9bd4e9c9ff6a2a9b5969462ba26216af3e010df0377dad8320ab515262ef8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Performance-optimized type for generic version ranges and operations on them."
HOMEPAGE="https://github.com/pubgrub-rs/pubgrub"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)
