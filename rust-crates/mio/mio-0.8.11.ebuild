# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="mio"
CRATE_VERSION="0.8.11"
CRATE_CHECKSUM="a4a650543ca06a924e8b371db273b2756685faae30f8487da1b56505a8f78b0c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lightweight non-blocking I/O."
HOMEPAGE="https://github.com/tokio-rs/mio"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"net"
	"os-ext"
	"os-poll"
)
