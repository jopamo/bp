# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral_async_zip"
CRATE_VERSION="0.0.17"
CRATE_CHECKSUM="ab72a761e6085828cc8f0e05ed332b2554701368c5dc54de551bfaec466518ba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An asynchronous ZIP archive reading/writing crate."
HOMEPAGE="https://github.com/Majored/rs-async-zip"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bzip2"
	"deflate"
	"deflate64"
	"full"
	"full-wasm"
	"lzma"
	"tokio"
	"tokio-fs"
	"xz"
	"zstd"
)
