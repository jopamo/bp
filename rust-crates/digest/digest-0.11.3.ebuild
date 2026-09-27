# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="digest"
CRATE_VERSION="0.11.3"
CRATE_CHECKSUM="f1dd6dbb5841937940781866fa1281a1ff7bd3bf827091440879f9994983d5c2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for cryptographic hash functions and message authentication codes"
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"block-api"
	"default"
	"dev"
	"getrandom"
	"mac"
	"oid"
	"rand_core"
	"zeroize"
)
