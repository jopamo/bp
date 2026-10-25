# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="h2"
CRATE_VERSION="0.4.19"
CRATE_CHECKSUM="ef8e5e5a340588f4452631496976cf8636d4a7ecf600239fdc27615d2530bc16"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An HTTP/2 client and server"
HOMEPAGE="https://github.com/hyperium/h2"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"stream"
	"unstable"
)
