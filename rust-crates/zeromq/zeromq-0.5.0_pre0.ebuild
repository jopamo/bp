# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zeromq"
CRATE_VERSION="0.5.0-pre"
CRATE_CHECKSUM="a1fe92954d37e77bed5e2775cb0fed7dba5f6bc4be6f7f76172a4eb371dc6a9b"
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
