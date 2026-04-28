# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro"
CRATE_VERSION="0.2.106"
CRATE_CHECKSUM="48cb0d2638f8baedbc542ed444afc0644a29166f1595371af4fecf8ce1e7eeb3"
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
