# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-config2"
CRATE_VERSION="0.1.44"
CRATE_CHECKSUM="25ada53f7339c78084fb37d7e17f34e76537541c4fbb02fa3a2baa14b8faad37"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Load and resolve Cargo configuration."
HOMEPAGE="https://github.com/taiki-e/cargo-config2"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
