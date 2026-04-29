# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro"
CRATE_VERSION="0.2.117"
CRATE_CHECKSUM="7fbdf9a35adf44786aecd5ff89b4563a90325f9da0923236f6104e603c7e86be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Definition of the \`#[wasm_bindgen]\` attribute, an internal dependency"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"strict-macro"
)
