# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="num-iter"
CRATE_VERSION="0.1.46"
CRATE_CHECKSUM="c92800bd69a1eac91786bcfe9da64a897eb72911b8dc3095decbd07429e8048b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="External iterators for generic mathematics"
HOMEPAGE="https://github.com/rust-num/num-iter"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"i128"
	"std"
)
