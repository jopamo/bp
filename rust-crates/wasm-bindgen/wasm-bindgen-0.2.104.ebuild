# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen"
CRATE_VERSION="0.2.104"
CRATE_CHECKSUM="c1da10c01ae9f1ae40cbfac0bac3b1e724b320abfcf52229f80b547c0d250e2d"
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
