# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="indexmap"
CRATE_VERSION="2.14.1"
CRATE_CHECKSUM="07aa2048142242915a31d35844fb311e0e53fcca590c3a0a40dcf1b841fa09eb"
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
	"serde"
	"std"
	"test_debug"
)
