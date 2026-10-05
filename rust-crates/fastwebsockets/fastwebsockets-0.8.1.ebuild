# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fastwebsockets"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="9dac026e15fb7e44d768880b868a0fd5bd30ffdee272e88b3060f657a5a72947"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast RFC6455 WebSocket server implementation"
HOMEPAGE="https://github.com/denoland/fastwebsockets"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"simd"
	"unstable-split"
	"upgrade"
	"with_axum"
)
