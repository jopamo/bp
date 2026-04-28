# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zstd-sys"
CRATE_VERSION="2.0.16+zstd.1.5.7"
CRATE_CHECKSUM="91e19ebc2adc8f83e43039e79776e3fda8ca919132d68a1fed6a5faca2683748"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low-level bindings for the zstd compression library."
HOMEPAGE="https://github.com/gyscos/zstd-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
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
	"zdict_builder"
	"zstdmt"
)
