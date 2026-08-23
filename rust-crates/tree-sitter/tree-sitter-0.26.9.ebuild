# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tree-sitter"
CRATE_VERSION="0.26.9"
CRATE_CHECKSUM="4dab76d0b724ba557954125188cf0633a1ca43199ced82d95c7b9c32cc3de1f3"
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
