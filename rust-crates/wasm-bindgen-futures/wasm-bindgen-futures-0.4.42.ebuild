# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-futures"
CRATE_VERSION="0.4.42"
CRATE_CHECKSUM="76bc14366121efc8dbb487ab05bcc9d346b3b5ec0eaa76e46594cabbe51762c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bridging the gap between Rust Futures and JavaScript Promises"
HOMEPAGE="https://rustwasm.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"futures-core-03-stream"
)
