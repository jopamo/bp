# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="camino"
CRATE_VERSION="1.1.10"
CRATE_CHECKSUM="0da45bc31171d8d6960122e222a67740df867c1dd53b4d51caa297084c185cab"
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
