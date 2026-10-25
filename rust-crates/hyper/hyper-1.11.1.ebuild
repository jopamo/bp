# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hyper"
CRATE_VERSION="1.11.1"
CRATE_CHECKSUM="27b501faa50e7a26c3d3560ca625132f4078a17771f4810baf70475ae48cbe43"
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
