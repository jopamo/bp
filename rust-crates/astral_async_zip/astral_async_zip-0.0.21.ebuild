# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral_async_zip"
CRATE_VERSION="0.0.21"
CRATE_CHECKSUM="13f4a9bc6289d907c8e883d25026a54751d686da9926af271d0fc4cbe58a7f4d"
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
	"deflate"
	"deflate64"
	"full"
	"full-wasm"
	"jiff"
	"lzma"
	"tokio"
	"tokio-fs"
	"xz"
	"zstd"
)
