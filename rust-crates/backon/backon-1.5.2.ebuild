# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="backon"
CRATE_VERSION="1.5.2"
CRATE_CHECKSUM="592277618714fbcecda9a02ba7a8781f319d26532a88553bbacc77ba5d2b3a8d"
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
