# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="compression-codecs"
CRATE_VERSION="0.4.45"
CRATE_CHECKSUM="98fc98460ba0ad5317075d3632b8dfc45d0be8c4a49347c2a38272019717614a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Adaptors for various compression algorithms."
HOMEPAGE="https://github.com/Nullus157/async-compression"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all-algorithms"
	"brotli-mbrotli"
	"deflate"
	"deflate64"
	"gzip"
	"lz4"
	"lzma"
	"xz"
	"xz-parallel"
	"xz2"
	"zlib"
	"zstd"
	"zstdmt"
)
