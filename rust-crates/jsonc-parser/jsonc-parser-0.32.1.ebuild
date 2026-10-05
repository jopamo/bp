# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jsonc-parser"
CRATE_VERSION="0.32.1"
CRATE_CHECKSUM="8de0ffda8def4eb16ed430641db8056c2509b20e38f2dd327bdb4c83239f88c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="JSONC parser."
HOMEPAGE="https://github.com/dprint/jsonc-parser"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cst"
	"error_unicode_width"
	"preserve_order"
	"serde"
	"serde_json"
)
