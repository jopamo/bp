# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fastwebsockets"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="26da0c7b5cef45c521a6f9cdfffdfeb6c9f5804fbac332deb5ae254634c7a6be"
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
