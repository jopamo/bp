# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zstd-safe"
CRATE_VERSION="8.1.0"
CRATE_CHECKSUM="bdd44c6a7284e91f3717755b24315a302edd9153a01f753c3cba3d765e8eafac"
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
