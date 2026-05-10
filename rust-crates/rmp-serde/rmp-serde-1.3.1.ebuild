# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rmp-serde"
CRATE_VERSION="1.3.1"
CRATE_CHECKSUM="72f81bee8c8ef9b577d1681a70ebbc962c232461e397b22c208c43c04b67a155"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde support for MessagePack"
HOMEPAGE="https://github.com/3Hren/msgpack-rust"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
