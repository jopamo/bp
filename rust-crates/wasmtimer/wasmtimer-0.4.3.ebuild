# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="wasmtimer"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="1c598d6b99ea013e35844697fc4670d08339d5cda15588f193c6beedd12f644b"
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
