# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-futures"
CRATE_VERSION="0.4.54"
CRATE_CHECKSUM="7e038d41e478cc73bae0ff9b36c60cff1c98b8f38f8d7e8061e79ee63608ac5c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bridging the gap between Rust Futures and JavaScript Promises"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"futures-core-03-stream"
	"std"
)
