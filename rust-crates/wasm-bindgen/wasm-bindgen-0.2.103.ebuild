# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen"
CRATE_VERSION="0.2.103"
CRATE_CHECKSUM="ab10a69fbd0a177f5f649ad4d8d3305499c42bab9aef2f7ff592d0ec8f833819"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Easy support for interacting between JS and Rust."
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"enable-interning"
	"gg-alloc"
	"msrv"
	"serde-serialize"
	"spans"
	"std"
	"strict-macro"
	"xxx_debug_only_print_generated_code"
)
