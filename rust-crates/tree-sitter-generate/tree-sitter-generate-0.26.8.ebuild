# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tree-sitter-generate"
CRATE_VERSION="0.26.8"
CRATE_CHECKSUM="c3fb2e1bdb1d5f9d23cd5fa68cf98b3bedbd223c92a2edd60bbcf30bcf7180a5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for generating C source code from a tree-sitter grammar"
HOMEPAGE="https://tree-sitter.github.io/tree-sitter"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"load"
	"qjs-rt"
)
