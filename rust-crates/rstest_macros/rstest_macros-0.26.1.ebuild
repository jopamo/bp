# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rstest_macros"
CRATE_VERSION="0.26.1"
CRATE_CHECKSUM="9c845311f0ff7951c5506121a9ad75aec44d083c31583b2ea5a30bcb0b0abba0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust fixture based test framework. It use procedural macro to implement fixtures and table based tests."
HOMEPAGE="https://github.com/la10736/rstest"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-timeout"
	"crate-name"
	"default"
)
