# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unit-prefix"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="81e544489bf3d8ef66c953931f56617f423cd4b5494be343d9b9d3dda037b9a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Format numbers with metric and binary unit prefixes"
HOMEPAGE="https://codeberg.org/commons-rs/unit-prefix"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
