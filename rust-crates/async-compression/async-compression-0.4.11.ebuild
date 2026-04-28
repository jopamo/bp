# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="async-compression"
CRATE_VERSION="0.4.11"
CRATE_CHECKSUM="cd066d0b4ef8ecb03a55319dc13aa6910616d0f44008a045bb1835af830abff5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Adaptors between compression crates and Rust's modern asynchronous IO types."
HOMEPAGE="https://github.com/Nullus157/async-compression"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
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
