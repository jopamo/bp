# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen-macro-support"
CRATE_VERSION="0.2.114"
CRATE_CHECKSUM="03ce4caeaac547cdf713d280eda22a730824dd11e6b8c3ca9e42247b25c631e3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation APIs for the \`#[wasm_bindgen]\` attribute"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"extra-traits"
	"strict-macro"
)
