# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="mio"
CRATE_VERSION="1.2.2"
CRATE_CHECKSUM="30d65c71f1ce40ab09135ce117d742b9f8a19ff91a41a8b57ed50bc2de59c427"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lightweight non-blocking I/O."
HOMEPAGE="https://github.com/tokio-rs/mio"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"net"
	"os-ext"
	"os-poll"
)
