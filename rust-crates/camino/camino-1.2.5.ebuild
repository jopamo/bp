# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="camino"
CRATE_VERSION="1.2.5"
CRATE_CHECKSUM="bb1307f12aa967b5a58416e87b3653360e0fd614a016b6e970db08fecbb1b80d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UTF-8 paths"
HOMEPAGE="https://github.com/camino-rs/camino"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"proptest1"
	"serde1"
)
