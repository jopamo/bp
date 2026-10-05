# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="target-triple"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="591ef38edfb78ca4771ee32cf494cb8771944bee237a9b91fc9c1424ac4b777b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="TARGET and HOST triples"
HOMEPAGE="https://github.com/dtolnay/target-triple"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
