# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tree-sitter"
CRATE_VERSION="0.25.9"
CRATE_CHECKSUM="ccd2a058a86cfece0bf96f7cce1021efef9c8ed0e892ab74639173e5ed7a34fa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings to the Tree-sitter parsing library"
HOMEPAGE="https://tree-sitter.github.io/tree-sitter"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"wasm"
)
