# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="indexmap"
CRATE_VERSION="2.10.0"
CRATE_CHECKSUM="fe4cd85333e22411419a0bcae1297d25e58c9443848b11dc6a86fefe8c78a661"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A hash table with consistent order and fast iteration."
HOMEPAGE="https://github.com/indexmap-rs/indexmap"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"test_debug"
)
