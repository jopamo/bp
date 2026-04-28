# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wayland-protocols-wlr"
CRATE_VERSION="0.3.9"
CRATE_CHECKSUM="efd94963ed43cf9938a090ca4f7da58eb55325ec8200c3848963e98dc25b78ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generated API for the WLR wayland protocol extensions"
HOMEPAGE="https://github.com/smithay/wayland-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"client"
	"server"
)
