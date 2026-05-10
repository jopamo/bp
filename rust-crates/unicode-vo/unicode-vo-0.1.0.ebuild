# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-vo"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="b1d386ff53b415b7fe27b50bb44679e2cc4660272694b7b6f3326d8480823a94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unicode vertical orientation detection"
HOMEPAGE="https://github.com/RazrFalcon/unicode-vo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
