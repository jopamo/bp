# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zeromq"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="efb2c254fd8f366755335c9e43b865f8484fe3bd717d65ffe7c3f28852863030"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A native Rust implementation of ZeroMQ"
HOMEPAGE="https://github.com/zeromq/zmq.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all-transport"
	"async-dispatcher-macros"
	"async-dispatcher-runtime"
	"async-std-runtime"
	"default"
	"ipc-transport"
	"tcp-transport"
	"tokio-runtime"
)
