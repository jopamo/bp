# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="camino"
CRATE_VERSION="1.2.6"
CRATE_CHECKSUM="bbbad30e4b4c14a39e3cc8aed085a12a327257c316619c93581e017bc52be591"
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
