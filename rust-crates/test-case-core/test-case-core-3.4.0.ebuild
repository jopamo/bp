# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="test-case-core"
CRATE_VERSION="3.4.0"
CRATE_CHECKSUM="bd097615b407247e102046ba34426bb594923ab3554cf0f3cdfed050f1a5a3e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides core functionality for parsing #[test_case(...)] procedural macro attribute for generating parametrized test cases easily"
HOMEPAGE="https://github.com/frondeus/test-case"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"with-regex"
)
