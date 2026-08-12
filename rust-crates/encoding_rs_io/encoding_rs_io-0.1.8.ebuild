# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="encoding_rs_io"
CRATE_VERSION="0.1.8"
CRATE_CHECKSUM="fba3fe847045ecff794b9c138293a80db914678c453ad63fbf0c6a9eb6e00b22"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Streaming transcoding for encoding_rs"
HOMEPAGE="https://github.com/BurntSushi/encoding_rs_io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
