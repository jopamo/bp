# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tree-sitter"
CRATE_VERSION="0.26.8"
CRATE_CHECKSUM="887bd495d0582c5e3e0d8ece2233666169fa56a9644d172fc22ad179ab2d0538"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings to the Tree-sitter parsing library"
HOMEPAGE="https://tree-sitter.github.io/tree-sitter"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"wasm"
)
