# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="xxhash-rust"
CRATE_VERSION="0.8.15"
CRATE_CHECKSUM="fdd20c5420375476fbd4394763288da7eb0cc0b8c11deed431a91562af7335d3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation of xxhash"
HOMEPAGE="https://github.com/DoumanAsh/xxhash-rust"
LICENSE="BSL-1.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const_xxh3"
	"const_xxh32"
	"const_xxh64"
	"std"
	"xxh3"
	"xxh32"
	"xxh64"
)
