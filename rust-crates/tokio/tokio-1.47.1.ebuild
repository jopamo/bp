# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tokio"
CRATE_VERSION="1.47.1"
CRATE_CHECKSUM="89e49afdadebb872d3145a5638b59eb0691ea23e46ca484037cfab3b76b95038"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An event-driven, non-blocking I/O platform for writing asynchronous I/O backed applications."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fs"
	"full"
	"io-std"
	"io-util"
	"macros"
	"net"
	"process"
	"rt"
	"rt-multi-thread"
	"signal"
	"sync"
	"test-util"
	"time"
)
