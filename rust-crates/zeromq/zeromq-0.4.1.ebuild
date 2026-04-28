# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zeromq"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="6a4528179201f6eecf211961a7d3276faa61554c82651ecc66387f68fc3004bd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A native Rust implementation of ZeroMQ"
HOMEPAGE="https://github.com/zeromq/zmq.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
