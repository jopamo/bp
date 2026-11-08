# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zstd-safe"
CRATE_VERSION="8.2.0"
CRATE_CHECKSUM="ded520f16b29e1a9b771c722221b2b0a0398c2316d9bb3c42b458a5414d7434b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safe low-level bindings for the zstd compression library."
HOMEPAGE="https://github.com/gyscos/zstd-rs"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arrays"
	"bindgen"
	"cmake"
	"debug"
	"default"
	"doc-cfg"
	"experimental"
	"fat-lto"
	"legacy"
	"no_asm"
	"pkg-config"
	"seekable"
	"std"
	"thin"
	"thin-lto"
	"vendored"
	"with-rust-allocator"
	"zdict_builder"
	"zstdmt"
)
