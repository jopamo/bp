# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="gearhash"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="c8cf82cf76cd16485e56295a1377c775ce708c9f1a0be6b029076d60a245d213"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast, SIMD-accelerated hash function for content-defined chunking"
HOMEPAGE="https://github.com/srijs/rust-gearhash"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
)
