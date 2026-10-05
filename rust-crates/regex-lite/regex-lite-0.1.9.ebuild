# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="regex-lite"
CRATE_VERSION="0.1.9"
CRATE_CHECKSUM="cab834c73d247e67f4fae452806d17d3c7501756d98c8808d7c9c7aa7d18f973"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A lightweight regex engine that optimizes for binary size and compilation time."
HOMEPAGE="https://github.com/rust-lang/regex/tree/master/regex-lite"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"string"
)
