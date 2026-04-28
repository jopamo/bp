# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wayland-backend"
CRATE_VERSION="0.3.11"
CRATE_CHECKSUM="673a33c33048a5ade91a6b139580fa174e19fb0d23f396dca9fa15f2e1e49b35"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low-level bindings to the Wayland protocol"
HOMEPAGE="https://github.com/smithay/wayland-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"client_system"
	"dlopen"
	"server_system"
)
