# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral_async_zip"
CRATE_VERSION="0.0.22"
CRATE_CHECKSUM="0f8508d09c6bc6abd42767d1d43c7702891691484875ce94f7997da1301d95e9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An asynchronous ZIP archive reading/writing crate."
HOMEPAGE="https://github.com/astral-sh/rs-async-zip"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bzip2"
	"bzip2-read"
	"bzip2-write"
	"deflate"
	"deflate-read"
	"deflate-write"
	"deflate64"
	"deflate64-read"
	"full"
	"full-wasm"
	"jiff"
	"lzma"
	"lzma-read"
	"lzma-write"
	"tokio"
	"tokio-fs"
	"xz"
	"xz-read"
	"xz-write"
	"zstd"
	"zstd-read"
	"zstd-write"
)
