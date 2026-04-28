# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zstd"
CRATE_VERSION="0.13.3"
CRATE_CHECKSUM="e91ee311a569c327171651566e07972200e76fcfe2242a4fa446149a3881c08a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Binding for the zstd compression library."
HOMEPAGE="https://github.com/gyscos/zstd-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arrays"
	"bindgen"
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
	"wasm"
	"zdict_builder"
	"zstdmt"
)
