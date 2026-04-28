# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fixedbitset"
CRATE_VERSION="0.5.7"
CRATE_CHECKSUM="1d674e81391d1e1ab681a28d99df07927c6d4aa5b027d7da16ba32d1d21ecd99"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FixedBitSet is a simple bitset collection"
HOMEPAGE="https://github.com/petgraph/fixedbitset"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
