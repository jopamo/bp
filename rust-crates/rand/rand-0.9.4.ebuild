# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rand"
CRATE_VERSION="0.9.4"
CRATE_CHECKSUM="44c5af06bb1b7d3216d91932aed5265164bf384dc89cd6ba05cf59a35f5f76ea"
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
	"log"
	"nightly"
	"os_rng"
	"serde"
	"simd_support"
	"small_rng"
	"std"
	"std_rng"
	"thread_rng"
	"unbiased"
)
