# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="svgtypes"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="98ffacedcdcf1da6579c907279b4f3c5492fbce99fbbf227f5ed270a589c2765"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SVG types parser."
HOMEPAGE="https://github.com/RazrFalcon/svgtypes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
