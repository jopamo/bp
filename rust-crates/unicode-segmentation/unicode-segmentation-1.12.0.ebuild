# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="unicode-segmentation"
CRATE_VERSION="1.12.0"
CRATE_CHECKSUM="f6ccf251212114b54433ec949fd6a7841275f9ada20dddd2f29e9ceea4501493"
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
