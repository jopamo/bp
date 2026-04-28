# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="streaming-iterator"
CRATE_VERSION="0.1.9"
CRATE_CHECKSUM="2b2231b7c3057d5e4ad0156fb3dc807d900806020c5ffa3ee6ff2c8c76fb8520"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Streaming iterators"
HOMEPAGE="https://github.com/sfackler/streaming-iterator"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"std"
)
