# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="utf8-zero"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="b8c0a043c9540bae7c578c88f91dda8bd82e59ae27c21baca69c8b191aaf5a6e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zero-copy, incremental UTF-8 decoding with error handling"
HOMEPAGE="https://github.com/algesten/utf8-zero"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
