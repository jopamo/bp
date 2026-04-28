# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dprint-plugin-jupyter"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="70170f0c0b85500d8a1a240d0c969903e0c282cdc92d0579fa57e26a814f9f0a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Formats code blocks in Jupyter notebooks."
HOMEPAGE="https://github.com/dprint/dprint-plugin-jupyter"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"wasm"
)
