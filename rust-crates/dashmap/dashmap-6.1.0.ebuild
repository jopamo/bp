# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dashmap"
CRATE_VERSION="6.1.0"
CRATE_CHECKSUM="5041cc499144891f3790297212f32a74fb938e5136a14943f338ef9e0ae276cf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Blazing fast concurrent HashMap for Rust."
HOMEPAGE="https://github.com/xacrimon/dashmap"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"inline"
	"raw-api"
	"typesize"
)
