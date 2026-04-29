# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="protobuf"
CRATE_VERSION="2.28.0"
CRATE_CHECKSUM="106dd99e98437432fed6519dedecfade6a06a73bb7b2a1e019fdd2bee5778d94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust implementation of Google protocol buffers"
HOMEPAGE="https://github.com/stepancheg/rust-protobuf/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"with-bytes"
	"with-serde"
)
