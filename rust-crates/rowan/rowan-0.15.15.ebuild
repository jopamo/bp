# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rowan"
CRATE_VERSION="0.15.15"
CRATE_CHECKSUM="32a58fa8a7ccff2aec4f39cc45bf5f985cec7125ab271cf681c279fd00192b49"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for generic lossless syntax trees"
HOMEPAGE="https://github.com/rust-analyzer/rowan"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde1"
)
