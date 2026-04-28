# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ipconfig"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="b58db92f96b720de98181bbbe63c831e87005ab460c1bf306eb2622b4707997f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Get network adapters information and network configuration for windows."
HOMEPAGE="https://github.com/liranringel/ipconfig"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"computer"
	"default"
)
