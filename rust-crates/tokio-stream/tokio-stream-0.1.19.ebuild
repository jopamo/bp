# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tokio-stream"
CRATE_VERSION="0.1.19"
CRATE_CHECKSUM="a3d06f0b082ba57c26b79407372e57cf2a1e28124f78e9479fe80322cf53420b"
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
	"rt"
	"signal"
	"sync"
	"time"
)
