# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="hyper"
CRATE_VERSION="1.8.1"
CRATE_CHECKSUM="2ab2d4f250c3d7b1c9fcdff1cece94ea4e2dfbec68614f7b87cb205f24ca9d11"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A protective and efficient HTTP library for all."
HOMEPAGE="https://hyper.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"capi"
	"client"
	"default"
	"ffi"
	"full"
	"http1"
	"http2"
	"nightly"
	"server"
	"tracing"
)
