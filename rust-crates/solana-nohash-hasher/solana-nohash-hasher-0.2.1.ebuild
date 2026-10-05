# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="solana-nohash-hasher"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="8b8a731ed60e89177c8a7ab05fe0f1511cedd3e70e773f288f9de33a9cfdc21e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of \`std::hash::Hasher\` which does not hash at all."
HOMEPAGE="https://github.com/solana-labs/nohash-hasher"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
