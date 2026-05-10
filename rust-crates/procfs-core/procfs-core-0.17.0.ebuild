# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="procfs-core"
CRATE_VERSION="0.17.0"
CRATE_CHECKSUM="239df02d8349b06fc07398a3a1697b06418223b1c7725085e801e7c0fc6a12ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data structures and parsing for the linux procfs pseudo-filesystem"
HOMEPAGE="https://github.com/eminence/procfs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde1"
)
