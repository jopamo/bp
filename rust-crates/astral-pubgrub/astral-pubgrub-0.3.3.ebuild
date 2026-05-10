# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral-pubgrub"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="d6cb15b4f5096a3a1b41fdc2736a1c33d87c78f34d3c1ec2b669e766edadd559"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="PubGrub version solving algorithm"
HOMEPAGE="https://github.com/astral-sh/pubgrub"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)
