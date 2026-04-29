# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tracing-attributes"
CRATE_VERSION="0.1.31"
CRATE_CHECKSUM="7490cfa5ec963746568740651ac6781f701c9c5ea257c58e057f3ba8cf69e8da"
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
