# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tree-sitter-python"
CRATE_VERSION="0.25.0"
CRATE_CHECKSUM="6bf85fd39652e740bf60f46f4cda9492c3a9ad75880575bf14960f775cb74a1c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Python grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-python"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
