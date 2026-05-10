# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="svgtypes"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="c9ee29c1407a5b18ccfe5f6ac82ac11bab3b14407e09c209a6c1a32098b19734"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SVG types parser."
HOMEPAGE="https://github.com/RazrFalcon/svgtypes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
