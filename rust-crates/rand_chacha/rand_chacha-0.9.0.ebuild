# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_chacha"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ChaCha random number generator"
HOMEPAGE="https://rust-random.github.io/book"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"os_rng"
	"serde"
	"std"
)
