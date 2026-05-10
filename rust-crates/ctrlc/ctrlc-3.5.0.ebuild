# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ctrlc"
CRATE_VERSION="3.5.0"
CRATE_CHECKSUM="881c5d0a13b2f1498e2306e82cbada78390e152d4b1378fb28a84f4dcd0dc4f3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Easy Ctrl-C handler for Rust projects"
HOMEPAGE="https://github.com/Detegr/rust-ctrlc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"termination"
)
