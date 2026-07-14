# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="defmt-macros"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="f0a27770e9c8f719a79d8b638281f4d828f77d8fd61e0bd94451b9b85e576a0b"
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
