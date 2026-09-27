# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="salsa-macros"
CRATE_VERSION="0.28.2"
CRATE_CHECKSUM="445be2bfbb2f67cb663225ecd7bc5a25370c0250fca30f9d8cbad9a913650370"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros for the salsa crate"
HOMEPAGE="https://github.com/salsa-rs/salsa"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"persistence"
)
