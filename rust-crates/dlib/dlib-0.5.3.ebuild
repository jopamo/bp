# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="dlib"
CRATE_VERSION="0.5.3"
CRATE_CHECKSUM="ab8ecd87370524b461f8557c119c405552c396ed91fc0a8eec68679eab26f94a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper macros for handling manually loading optional system libraries."
HOMEPAGE="https://github.com/elinorbgr/dlib"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
