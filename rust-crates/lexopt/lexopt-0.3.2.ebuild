# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="lexopt"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="803ec87c9cfb29b9d2633f20cba1f488db3fd53f2158b1024cbefb47ba05d413"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimalist pedantic command line parser"
HOMEPAGE="https://github.com/blyxxyz/lexopt"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
