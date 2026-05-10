# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde-untagged"
CRATE_VERSION="0.1.9"
CRATE_CHECKSUM="f9faf48a4a2d2693be24c6289dbe26552776eb7737074e6722891fadbe6c5058"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde \`Visitor\` implementation for deserializing untagged enums"
HOMEPAGE="https://github.com/dtolnay/serde-untagged"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
