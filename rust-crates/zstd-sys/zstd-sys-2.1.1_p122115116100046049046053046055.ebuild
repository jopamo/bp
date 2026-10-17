# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zstd-sys"
CRATE_VERSION="2.1.1+zstd.1.5.7"
CRATE_CHECKSUM="aeec9eaf2dffbbd09201e23bd0ffcbaa33bb8e9266a10734fd7ed90a85eca078"
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
