# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tokio"
CRATE_VERSION="1.50.0"
CRATE_CHECKSUM="27ad5e34374e03cfffefc301becb44e9dc3c17584f414349ebe29ed26661822d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An event-driven, non-blocking I/O platform for writing asynchronous I/O backed applications."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fs"
	"full"
	"io-std"
	"io-uring"
	"io-util"
	"macros"
	"net"
	"process"
	"rt"
	"rt-multi-thread"
	"signal"
	"sync"
	"taskdump"
	"test-util"
	"time"
)
