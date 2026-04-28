# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="js-sys"
CRATE_VERSION="0.3.83"
CRATE_CHECKSUM="464a3709c7f55f1f721e5389aa6ea4e3bc6aba669353300af094b29ffbdde1d8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings for all JS global objects and functions in all JS environments like Node.js and browsers, built on \`#[wasm_bindgen]\` using the \`wasm-bindgen\` crate."
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
