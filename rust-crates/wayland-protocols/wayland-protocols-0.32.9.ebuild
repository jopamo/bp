# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wayland-protocols"
CRATE_VERSION="0.32.9"
CRATE_CHECKSUM="efa790ed75fbfd71283bd2521a1cfdc022aabcc28bdcff00851f9e4ae88d9901"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generated API for the officials wayland protocol extensions"
HOMEPAGE="https://github.com/smithay/wayland-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"client"
	"server"
	"staging"
	"unstable"
)
