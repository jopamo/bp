# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="liblzma-sys"
CRATE_VERSION="0.4.6"
CRATE_CHECKSUM="1a60851d15cd8c5346eca4ab8babff585be2ae4bc8097c067291d3ffe2add3b6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw bindings to liblzma which contains an implementation of LZMA and xz stream encoding/decoding. High level Rust bindings are available in the \`liblzma\` crate."
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
