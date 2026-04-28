# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="test-case-core"
CRATE_VERSION="3.3.1"
CRATE_CHECKSUM="adcb7fd841cd518e279be3d5a3eb0636409487998a4aff22f3de87b81e88384f"
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
