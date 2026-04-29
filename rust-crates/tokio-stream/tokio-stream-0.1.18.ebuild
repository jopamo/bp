# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tokio-stream"
CRATE_VERSION="0.1.18"
CRATE_CHECKSUM="32da49809aab5c3bc678af03902d4ccddea2a87d028d86392a4b1560c6906c70"
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
