# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="png"
CRATE_VERSION="0.17.16"
CRATE_CHECKSUM="82151a2fc869e011c153adc57cf2789ccb8d9906ce52c0b39a6b5697749d7526"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="PNG decoding and encoding library in pure Rust"
HOMEPAGE="https://github.com/image-rs/image-png"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"benchmarks"
	"unstable"
)
