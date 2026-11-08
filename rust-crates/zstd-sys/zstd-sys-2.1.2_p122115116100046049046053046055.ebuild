# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zstd-sys"
CRATE_VERSION="2.1.2+zstd.1.5.7"
CRATE_CHECKSUM="481ada9c543b2323cbb7bbdbb5249177fbf0188ed959ed2c15e4b22421c84ed3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low-level bindings for the zstd compression library."
HOMEPAGE="https://github.com/gyscos/zstd-rs"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cmake"
	"debug"
	"default"
	"experimental"
	"fat-lto"
	"legacy"
	"no_asm"
	"no_wasm_shim"
	"non-cargo"
	"pkg-config"
	"seekable"
	"std"
	"thin"
	"thin-lto"
	"vendored"
	"zdict_builder"
	"zstdmt"
)
