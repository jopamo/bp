# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_test_fixture"
CRATE_VERSION="0.0.352"
CRATE_CHECKSUM="602da840e556d286430fab93aedf5390cdf54773f474986321cec2b8efa8b9f2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Test fixtures for rust-analyzer."
HOMEPAGE="https://crates.io/crates/ra_ap_test_fixture"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"in-rust-tree"
)
