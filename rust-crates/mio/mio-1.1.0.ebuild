# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="mio"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="69d83b0086dc8ecf3ce9ae2874b2d1290252e2a30720bea58a5c6639b0092873"
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
