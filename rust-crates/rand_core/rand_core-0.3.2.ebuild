# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rand_core"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="96f815e01bbd9678b50d927f79aa1cf3ffdfdb1b9787317c1284dadb894ad0e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core random number generator traits and tools for implementation."
HOMEPAGE="https://crates.io/crates/rand_core"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"serde1"
	"std"
)
