# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="smithay-client-toolkit"
CRATE_VERSION="0.19.2"
CRATE_CHECKSUM="3457dea1f0eb631b4034d61d4d8c32074caa6cd1ab2d59f2327bd8461e2c0016"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Toolkit for making client wayland applications."
HOMEPAGE="https://github.com/smithay/client-toolkit"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"calloop"
	"default"
	"xkbcommon"
)
