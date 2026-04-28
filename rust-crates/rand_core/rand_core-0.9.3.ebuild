# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_core"
CRATE_VERSION="0.9.3"
CRATE_CHECKSUM="99d9a13982dcf210057a8a78572b2217b667c3beacbf3a0d8b454f6f82837d38"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core random number generator traits and tools for implementation."
HOMEPAGE="https://rust-random.github.io/book"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"os_rng"
	"serde"
	"std"
)
