# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="async-compression"
CRATE_VERSION="0.4.46"
CRATE_CHECKSUM="4f10dafd0c8d2e51ae9a748805777613ed0bbe17bf586b76c8311f45c020a32f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Adaptors between compression crates and Rust's modern asynchronous IO types."
HOMEPAGE="https://github.com/Nullus157/async-compression"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
	"all-algorithms"
	"all-implementations"
	"brotli"
	"bzip2"
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
