# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rand_core"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="0e5937858e6fd18cd595d558f90bb5de3b72ae23f9e3763af0e805949b04ef60"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core random number generator traits and tools for implementation."
HOMEPAGE="https://crates.io/crates/rand_core"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"serde1"
	"std"
)
