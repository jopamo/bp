# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cssparser"
CRATE_VERSION="0.36.0"
CRATE_CHECKSUM="dae61cf9c0abb83bd659dab65b7e4e38d8236824c85f0f804f173567bda257d2"
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
