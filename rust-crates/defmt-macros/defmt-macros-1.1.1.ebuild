# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="defmt-macros"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="bad9c72e7ca2137e0dc3813245a0d282fd6daad32fd800af018306a9169b5fe8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="defmt macros"
HOMEPAGE="https://github.com/knurling-rs/defmt"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"unstable-test"
)
