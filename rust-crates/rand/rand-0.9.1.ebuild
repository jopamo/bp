# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="9fbfd9d094a40bf3ae768db9361049ace4c0e04a4fd6b359518bd7b73a73dd97"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Random number generators and other randomness functionality."
HOMEPAGE="https://rust-random.github.io/book"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
