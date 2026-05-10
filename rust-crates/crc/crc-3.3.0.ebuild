# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="crc"
CRATE_VERSION="3.3.0"
CRATE_CHECKSUM="9710d3b3739c2e349eb44fe848ad0b7c8cb1e42bd87ee49371df2f7acaf3e675"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust implementation of CRC with support of various standards"
HOMEPAGE="https://github.com/mrhooray/crc-rs.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
