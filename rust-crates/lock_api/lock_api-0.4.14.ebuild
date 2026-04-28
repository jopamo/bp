# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lock_api"
CRATE_VERSION="0.4.14"
CRATE_CHECKSUM="224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Wrappers to create fully-featured Mutex and RwLock types. Compatible with no_std."
HOMEPAGE="https://github.com/Amanieu/parking_lot"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"arc_lock"
	"atomic_usize"
	"default"
	"nightly"
)
