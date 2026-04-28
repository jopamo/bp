# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tracing-log"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="ee855f1f400bd0e5c02d150ae5de3840039a3f54b025156404e34c23c03f47c3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides compatibility between `tracing` and the `log` crate."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"interest-cache"
	"log-tracer"
	"std"
)
