# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fastbloom"
CRATE_VERSION="0.17.0"
CRATE_CHECKSUM="ef975e30683b2d965054bb0a836f8973857c4ebf6acf274fe46617cd285060d8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The fastest Bloom filter in Rust. No accuracy compromises. Full concurrency support and compatible with any hasher."
HOMEPAGE="https://github.com/tomtomwombat/fastbloom/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"loom"
	"rand"
	"serde"
	"std"
)
