# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen"
CRATE_VERSION="0.2.117"
CRATE_CHECKSUM="0551fc1bb415591e3372d0bc4780db7e587d84e2a7e79da121051c5c4b89d0b0"
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
	"rustversion"
	"serde-serialize"
	"spans"
	"std"
	"strict-macro"
	"xxx_debug_only_print_generated_code"
)
