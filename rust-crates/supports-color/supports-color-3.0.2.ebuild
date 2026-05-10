# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="supports-color"
CRATE_VERSION="3.0.2"
CRATE_CHECKSUM="c64fc7232dd8d2e4ac5ce4ef302b1d81e0b80d055b9d77c7c4f51f6aa4c867d6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Detects whether a terminal supports color, and gives details about that support."
HOMEPAGE="https://github.com/zkat/supports-color"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
