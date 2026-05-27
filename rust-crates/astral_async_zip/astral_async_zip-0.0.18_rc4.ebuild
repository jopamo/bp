# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral_async_zip"
CRATE_VERSION="0.0.18-rc4"
CRATE_CHECKSUM="9d523231a4339307c7699aa5d9492fe6873906afefc9d7853b5e7ffbfee3c7f1"
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
