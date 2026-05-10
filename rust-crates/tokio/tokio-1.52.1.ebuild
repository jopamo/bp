# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tokio"
CRATE_VERSION="1.52.1"
CRATE_CHECKSUM="b67dee974fe86fd92cc45b7a95fdd2f99a36a6d7b0d431a231178d3d670bbcc6"
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
