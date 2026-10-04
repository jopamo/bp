# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rand"
CRATE_VERSION="0.8.8"
CRATE_CHECKSUM="e058c7de0b26af77780c769414d6257830bb240f3c38477dbc2c16e5f54d6d4c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Random number generators and other randomness functionality."
HOMEPAGE="https://rust-random.github.io/book"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"getrandom"
	"log"
	"min_const_gen"
	"nightly"
	"serde1"
	"small_rng"
	"std"
	"std_rng"
)
