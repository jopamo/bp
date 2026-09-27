# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_test_fixture"
CRATE_VERSION="0.0.347"
CRATE_CHECKSUM="77da42ce97d6b9de208c9e9fba23244da564130ee0d892af03d0a6eb72ba8672"
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
