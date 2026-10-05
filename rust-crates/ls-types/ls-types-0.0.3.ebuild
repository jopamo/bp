# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ls-types"
CRATE_VERSION="0.0.3"
CRATE_CHECKSUM="c029d4b509074b7d59dac432d87d4c24badaaf6c6c9c8b7ac030ae8022dc118d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Types for the Language Server Protocol specification"
HOMEPAGE="https://github.com/tower-lsp-community/ls-types"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"proposed"
)
