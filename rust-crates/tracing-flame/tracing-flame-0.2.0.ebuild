# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tracing-flame"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="0bae117ee14789185e129aaee5d93750abe67fdc5a9a62650452bfe4e122a3a9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tracing layer for creating flamegraphs from span timings"
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"smallvec"
)
