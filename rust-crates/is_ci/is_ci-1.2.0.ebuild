# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="is_ci"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="7655c9839580ee829dfacba1d1278c2b7883e50a277ff7541299489d6bdfdc45"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Super lightweight CI environment checker. Just tells you if you're in CI or not without much fuss."
HOMEPAGE="https://github.com/zkat/is_ci"
LICENSE="ISC"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
