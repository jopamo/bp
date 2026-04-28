# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="spdx"
CRATE_VERSION="0.13.4"
CRATE_CHECKSUM="a8da593e30beb790fc9424502eb898320b44e5eb30367dbda1c1edde8e2f32d7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper crate for SPDX expressions"
HOMEPAGE="https://github.com/EmbarkStudios/spdx"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"detection"
	"detection-cache"
	"detection-inline-cache"
	"detection-parallel"
	"std"
	"text"
)
