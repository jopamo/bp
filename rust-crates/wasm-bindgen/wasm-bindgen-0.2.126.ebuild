# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wasm-bindgen"
CRATE_VERSION="0.2.126"
CRATE_CHECKSUM="4b067c0c11094aef6b7a801c1e34a26affafdf3d051dba08456b868789aaf9a4"
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
