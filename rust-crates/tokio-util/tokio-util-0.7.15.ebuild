# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tokio-util"
CRATE_VERSION="0.7.15"
CRATE_CHECKSUM="66a539a9ad6d5d281510d5bd368c973d636c02dbf8a67300bfb6b950696ad7df"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Additional utilities for working with Tokio."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__docs_rs"
	"codec"
	"compat"
	"default"
	"full"
	"io"
	"io-util"
	"net"
	"rt"
	"time"
)
