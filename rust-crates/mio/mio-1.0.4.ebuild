# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="mio"
CRATE_VERSION="1.0.4"
CRATE_CHECKSUM="78bed444cc8a2160f01cbcf811ef18cac863ad68ae8ca62092e8db51d51c761c"
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
