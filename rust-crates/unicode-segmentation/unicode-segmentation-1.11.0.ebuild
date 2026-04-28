# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-segmentation"
CRATE_VERSION="1.11.0"
CRATE_CHECKSUM="d4c87d22b6e3f4a18d4d40ef354e97c90fcb14dd91d7dc0aa9d8a1172ebf7202"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate provides Grapheme Cluster, Word and Sentence boundaries according to Unicode Standard Annex #29 rules."
HOMEPAGE="https://github.com/unicode-rs/unicode-segmentation"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"no_std"
)
