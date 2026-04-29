# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="lz4_flex"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="ab6473172471198271ff72e9379150e9dfd70d8e533e0752a27e515b48dd375e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fastest LZ4 implementation in Rust, no unsafe by default."
HOMEPAGE="https://github.com/pseitz/lz4_flex"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"checked-decode"
	"default"
	"frame"
	"nightly"
	"safe-decode"
	"safe-encode"
	"std"
)
