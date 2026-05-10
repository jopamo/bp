# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="lzma-rs"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="297e814c836ae64db86b36cf2a557ba54368d03f6afcd7d947c266692f71115e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A codec for LZMA, LZMA2 and XZ written in pure Rust"
HOMEPAGE="https://github.com/gendx/lzma-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"enable_logging"
	"raw_decoder"
	"stream"
)
