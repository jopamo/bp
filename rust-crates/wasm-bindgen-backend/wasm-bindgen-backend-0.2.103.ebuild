# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-backend"
CRATE_VERSION="0.2.103"
CRATE_CHECKSUM="0bb702423545a6007bbc368fde243ba47ca275e549c8a28617f56f6ba53b1d1c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Backend code generation of the wasm-bindgen tool"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"extra-traits"
)
