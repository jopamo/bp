# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="test-case"
CRATE_VERSION="3.3.1"
CRATE_CHECKSUM="eb2550dd13afcd286853192af8601920d959b14c401fcece38071d53bf0768a8"
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
