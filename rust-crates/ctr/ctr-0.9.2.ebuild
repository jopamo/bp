# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ctr"
CRATE_VERSION="0.9.2"
CRATE_CHECKSUM="0369ee1ad671834580515889b80f2ea915f23b8be8d0daa4bbaf2ac5c7590835"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="CTR block modes of operation"
HOMEPAGE="https://github.com/RustCrypto/block-modes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"block-padding"
	"std"
	"zeroize"
)
