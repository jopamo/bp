# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zstd"
CRATE_VERSION="0.14.2"
CRATE_CHECKSUM="057cfd910cfac363a0ada849592624b4c9ff2e10bef504c3433810d78ed96f93"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Binding for the zstd compression library."
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
	"thin"
	"thin-lto"
	"vendored"
	"wasm"
	"with-rust-allocator"
	"zdict_builder"
	"zstdmt"
)
