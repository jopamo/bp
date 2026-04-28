# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rstest"
CRATE_VERSION="0.26.1"
CRATE_CHECKSUM="f5a3193c063baaa2a95a33f03035c8a72b83d97a54916055ba22d35ed3839d49"
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
