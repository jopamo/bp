# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="test-case-macros"
CRATE_VERSION="3.3.1"
CRATE_CHECKSUM="5c89e72a01ed4c579669add59014b9a524d609c0c88c6a585ce37485879f6ffb"
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
