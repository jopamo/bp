# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="backon"
CRATE_VERSION="1.6.0"
CRATE_CHECKSUM="cffb0e931875b666fc4fcb20fee52e9bbd1ef836fd9e9e04ec21555f9f85f7ef"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Make retry like a built-in feature provided by Rust."
HOMEPAGE="https://github.com/Xuanwo/backon"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"embassy-sleep"
	"futures-timer-sleep"
	"gloo-timers-sleep"
	"std"
	"std-blocking-sleep"
	"tokio-sleep"
)
