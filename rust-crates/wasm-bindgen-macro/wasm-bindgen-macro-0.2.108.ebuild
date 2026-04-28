# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-macro"
CRATE_VERSION="0.2.108"
CRATE_CHECKSUM="008b239d9c740232e71bd39e8ef6429d27097518b6b30bdf9086833bd5b6d608"
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
