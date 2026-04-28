# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rayon-core"
CRATE_VERSION="1.12.1"
CRATE_CHECKSUM="1465873a3dfdaa8ae7cb14b4383657caab0b3e8a0aa9ae8e04b044854c8dfce2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core APIs for Rayon"
HOMEPAGE="https://github.com/rayon-rs/rayon"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"web_spin_lock"
)
