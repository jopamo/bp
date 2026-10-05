# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="liblzma"
CRATE_VERSION="0.4.6"
CRATE_CHECKSUM="b6033b77c21d1f56deeae8014eb9fbe7bdf1765185a6c508b5ca82eeaed7f899"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings to liblzma providing Read/Write streams as well as low-level in-memory encoding/decoding. forked from xz2."
HOMEPAGE="https://github.com/portable-network-archive/liblzma-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bindgen"
	"default"
	"fat-lto"
	"parallel"
	"static"
	"thin-lto"
	"uncheck_liblzma_version"
	"wasm"
)
