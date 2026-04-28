# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cssparser"
CRATE_VERSION="0.35.0"
CRATE_CHECKSUM="4e901edd733a1472f944a45116df3f846f54d37e67e68640ac8bb69689aca2aa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust implementation of CSS Syntax Level 3"
HOMEPAGE="https://github.com/servo/rust-cssparser"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
	"dummy_match_byte"
	"skip_long_tests"
)
