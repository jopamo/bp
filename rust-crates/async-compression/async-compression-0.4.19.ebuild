# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="async-compression"
CRATE_VERSION="0.4.19"
CRATE_CHECKSUM="06575e6a9673580f52661c92107baabffbf41e2141373441cbcdc47cb733003c"
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
	"deflate"
	"deflate64"
	"gzip"
	"lzma"
	"xz"
	"zlib"
	"zstd"
	"zstdmt"
)
