# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_tower_lsp"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="fea954c97c042563492c93dedaeddaf59a0c7a241d4a35a575cfaf4b42db0d14"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This is a fork of https://crates.io/crates/tower-lsp, used in Deno. At the moment only floating patches."
HOMEPAGE="https://crates.io/crates/deno_tower_lsp"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"proposed"
)
