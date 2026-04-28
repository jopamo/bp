# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zstd"
CRATE_VERSION="0.13.2"
CRATE_CHECKSUM="fcf2b778a664581e31e389454a7072dab1647606d44f7feea22cd5abb9c9f3f9"
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
