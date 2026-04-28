# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dprint-core"
CRATE_VERSION="0.67.4"
CRATE_CHECKSUM="2c1d827947704a9495f705d6aeed270fa21a67f825f22902c28f38dc3af7a9ae"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core library for dprint."
HOMEPAGE="https://github.com/dprint/dprint/tree/main/crates/core"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async_runtime"
	"communication"
	"default"
	"formatting"
	"process"
	"tracing"
	"wasm"
)
