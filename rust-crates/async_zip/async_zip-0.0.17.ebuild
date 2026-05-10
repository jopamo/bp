# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="async_zip"
CRATE_VERSION="0.0.17"
CRATE_CHECKSUM="ce4a973b11791ec11eb9142f3176b1ed476708e2aa430dad0b32e34c38477650"
CRATE_SOURCE="git+https://github.com/astral-sh/rs-async-zip?rev=285e48742b74ab109887d62e1ae79e7c15fd4878#285e48742b74ab109887d62e1ae79e7c15fd4878"
CRATE_SOURCE_KIND="git"

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
