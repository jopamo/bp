# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="test-case-macros"
CRATE_VERSION="3.4.0"
CRATE_CHECKSUM="f4ce35ece947bccac166e1ded639133827a953f69a48ba134d17f91108333082"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides #[test_case(...)] procedural macro attribute for generating parametrized test cases easily"
HOMEPAGE="https://github.com/frondeus/test-case"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"with-regex"
)
