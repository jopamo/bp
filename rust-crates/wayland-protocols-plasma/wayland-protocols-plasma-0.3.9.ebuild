# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wayland-protocols-plasma"
CRATE_VERSION="0.3.9"
CRATE_CHECKSUM="a07a14257c077ab3279987c4f8bb987851bf57081b93710381daea94f2c2c032"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generated API for the Plasma wayland protocol extensions"
HOMEPAGE="https://github.com/smithay/wayland-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"client"
	"server"
)
