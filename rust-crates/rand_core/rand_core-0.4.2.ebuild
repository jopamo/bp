# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_core"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="9c33a3c44ca05fa6f1807d8e6743f3824e8509beca625669633be0acbdf509dc"
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
