# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_isaac"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="ded997c9d5f13925be2a6fd7e66bf1872597f759fd9dd93513dd7e92e5a5ee08"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ISAAC random number generator"
HOMEPAGE="https://crates.io/crates/rand_isaac"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde1"
)
