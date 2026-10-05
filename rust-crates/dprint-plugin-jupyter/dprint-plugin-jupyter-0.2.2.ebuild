# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="dprint-plugin-jupyter"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="f703cac0273eb41521f4bd89cc4848007655cd88ee2d1dc24e08aff6fa074b00"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Formats code blocks in Jupyter notebooks."
HOMEPAGE="https://github.com/dprint/dprint-plugin-jupyter"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"wasm"
)
