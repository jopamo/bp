# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tokio-stream"
CRATE_VERSION="0.1.17"
CRATE_CHECKSUM="eca58d7bba4a75707817a2c44174253f9236b2d5fbd055602e9d5c07c139a047"
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
