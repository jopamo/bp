# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="futures-timer"
CRATE_VERSION="3.0.3"
CRATE_CHECKSUM="f288b0a4f20f9a56b5d1da57e2227c661b7b16168e2f72365f57b63326e29b24"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Timeouts for futures."
HOMEPAGE="https://github.com/async-rs/futures-timer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"wasm-bindgen"
)
