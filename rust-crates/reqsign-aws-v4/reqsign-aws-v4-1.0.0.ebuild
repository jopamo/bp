# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-aws-v4"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="9b0fb0ac0a8222efdb0746d83c5ec36c6bdb0f5310b4b92147e3de7c45ef6657"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Signing API requests without effort."
HOMEPAGE="https://github.com/Xuanwo/reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
