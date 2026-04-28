# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro"
CRATE_VERSION="0.2.105"
CRATE_CHECKSUM="04264334509e04a7bf8690f2384ef5265f05143a4bff3889ab7a3269adab59c2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Definition of the `#[wasm_bindgen]` attribute, an internal dependency"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"strict-macro"
)
