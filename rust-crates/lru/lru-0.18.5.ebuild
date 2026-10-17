# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="lru"
CRATE_VERSION="0.18.5"
CRATE_CHECKSUM="ef9ac18847474e638e3702b76c65d4eb93428471a74778ef0f1be711717f89b5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A LRU cache implementation"
HOMEPAGE="https://github.com/jeromefroe/lru-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
)
