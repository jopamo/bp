# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tokio-stream"
CRATE_VERSION="0.1.16"
CRATE_CHECKSUM="4f4e6ce100d0eb49a2734f8c0812bcd324cf357d21810932c5df6b96ef2b86f1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities to work with \`Stream\` and \`tokio\`."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fs"
	"full"
	"io-util"
	"net"
	"signal"
	"sync"
	"time"
)
