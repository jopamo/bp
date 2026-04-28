# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tracing-attributes"
CRATE_VERSION="0.1.30"
CRATE_CHECKSUM="81383ab64e72a7a8b8e13130c49e3dab29def6d0c7d76a03087b3cf71c5c6903"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macro attributes for automatically instrumenting functions."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-await"
)
