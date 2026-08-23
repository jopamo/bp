# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-platform"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="dd0061da739915fae12ea00e16397555ed4371a6bb285431aab930f61b0aa4ba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cargo's representation of a target platform."
HOMEPAGE="https://github.com/rust-lang/cargo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
