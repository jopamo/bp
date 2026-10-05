# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tonic-prost"
CRATE_VERSION="0.14.6"
CRATE_CHECKSUM="50849f68853be452acf590cde0b146665b8d507b3b8af17261df47e02c209ea0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Prost codec implementation for tonic"
HOMEPAGE="https://github.com/hyperium/tonic"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
