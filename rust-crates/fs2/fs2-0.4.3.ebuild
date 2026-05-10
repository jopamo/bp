# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fs2"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="9564fc758e15025b46aa6643b1b77d047d1a56a1aea6e01002ac0c7026876213"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform file locks and file duplication."
HOMEPAGE="https://github.com/danburkert/fs2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
