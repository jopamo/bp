# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="h2"
CRATE_VERSION="0.3.26"
CRATE_CHECKSUM="81fe527a889e1532da5c525686d96d4c2e74cdd345badf8dfef9f6b39dd5f5e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An HTTP/2 client and server"
HOMEPAGE="https://github.com/hyperium/h2"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"stream"
	"unstable"
)
