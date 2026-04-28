# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dashmap"
CRATE_VERSION="5.5.3"
CRATE_CHECKSUM="978747c1d849a7d2ee5e8adc0159961c48fb7e5db2f06af6723b80123bb53856"
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
)
