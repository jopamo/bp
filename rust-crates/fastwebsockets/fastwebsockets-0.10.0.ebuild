# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fastwebsockets"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="305d3ba574508e27190906d11707dad683e0494e6b85eae9b044cb2734a5e422"
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
