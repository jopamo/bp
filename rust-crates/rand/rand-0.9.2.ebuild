# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand"
CRATE_VERSION="0.9.2"
CRATE_CHECKSUM="6db2770f06117d490610c7488547d543617b21bfa07796d7a12f6f1bd53850d1"
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
