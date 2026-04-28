# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tokio-metrics"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="eace09241d62c98b7eeb1107d4c5c64ca3bd7da92e8c218c153ab3a78f9be112"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Runtime and task level metrics for Tokio applications."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"rt"
)
