# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tokio"
CRATE_VERSION="1.49.0"
CRATE_CHECKSUM="72a2903cd7736441aac9df9d7688bd0ce48edccaadf181c3b90be801e81d3d86"
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
