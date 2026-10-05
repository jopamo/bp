# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="swc_ecma_transforms_base"
CRATE_VERSION="30.0.1"
CRATE_CHECKSUM="250f6f165578ca4fee47bd57585c1b9597c94bf4ea6591df47f2b5fa5b1883fe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rust port of babel and closure compiler."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"concurrent"
	"concurrent-renamer"
	"inline-helpers"
)
