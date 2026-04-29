# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen"
CRATE_VERSION="0.2.100"
CRATE_CHECKSUM="1edc8929d7499fc4e8f0be2262a241556cfc54a0bea223790e71446f2aab1ef5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Easy support for interacting between JS and Rust."
HOMEPAGE="https://rustwasm.github.io/"
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
