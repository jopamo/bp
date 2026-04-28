# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tracing-attributes"
CRATE_VERSION="0.1.28"
CRATE_CHECKSUM="395ae124c09f9e6918a2310af6038fba074bcf474ac352496d5910dd59a2226d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macro attributes for automatically instrumenting functions."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-await"
)
