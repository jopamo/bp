# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="swc_ecma_codegen"
CRATE_VERSION="20.0.2"
CRATE_CHECKSUM="ff2a6ee1ec49dda8dedeac54e4147b4e8b3f278d9bb34ab28983257a393d34ed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ecmascript code generator for the swc project."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde-impl"
)
