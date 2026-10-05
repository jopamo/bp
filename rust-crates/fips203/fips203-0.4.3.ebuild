# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fips203"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="c8bdb6454f692ca2a2b45cd554c6828c639d7f9c968cf83a678899ec4443a280"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism"
HOMEPAGE="https://github.com/integritychain/fips203"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"default-rng"
	"ml-kem-1024"
	"ml-kem-512"
	"ml-kem-768"
)
