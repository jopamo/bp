# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tokio"
CRATE_VERSION="1.48.0"
CRATE_CHECKSUM="ff360e02eab121e0bc37a2d3b4d4dc622e6eda3a8e5253d5435ecf5bd4c68408"
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
