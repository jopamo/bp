# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jobserver"
CRATE_VERSION="0.1.33"
CRATE_CHECKSUM="38f262f097c174adebe41eb73d66ae9c06b2844fb0da69969647bbddd9b0538a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of the GNU Make jobserver for Rust."
HOMEPAGE="https://github.com/rust-lang/jobserver-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
