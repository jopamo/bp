# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wasmtimer"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="d8d49b5d6c64e8558d9b1b065014426f35c18de636895d24893dbbd329743446"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Time utils from std::time, tokio::time and tokio_util::time on WASM targets"
HOMEPAGE="https://github.com/whizsid/wasmtimer-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"tokio"
	"tokio-test-util"
	"tokio-util"
)
