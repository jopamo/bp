# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-segmentation"
CRATE_VERSION="1.13.2"
CRATE_CHECKSUM="9629274872b2bfaf8d66f5f15725007f635594914870f65218920345aa11aa8c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate provides Grapheme Cluster, Word and Sentence boundaries according to Unicode Standard Annex #29 rules."
HOMEPAGE="https://github.com/unicode-rs/unicode-segmentation"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"no_std"
)
