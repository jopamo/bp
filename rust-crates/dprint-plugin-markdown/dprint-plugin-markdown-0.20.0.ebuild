# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dprint-plugin-markdown"
CRATE_VERSION="0.20.0"
CRATE_CHECKSUM="897d39d10e75ae13b9c0f7e47ae5708d2c7117b53a34d5600714f801ca4b841e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Markdown formatter for dprint."
HOMEPAGE="https://github.com/dprint/dprint-plugin-markdown"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"tracing"
	"wasm"
)
