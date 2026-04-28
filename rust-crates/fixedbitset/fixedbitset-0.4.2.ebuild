# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fixedbitset"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="0ce7134b9999ecaf8bcd65542e436736ef32ddca1b3e06094cb6ec5755203b80"
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
