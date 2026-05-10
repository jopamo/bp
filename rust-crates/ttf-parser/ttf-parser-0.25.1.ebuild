# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ttf-parser"
CRATE_VERSION="0.25.1"
CRATE_CHECKSUM="d2df906b07856748fa3f6e0ad0cbaa047052d4a7dd609e231c4f72cee8c36f31"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A high-level, safe, zero-allocation font parser for TrueType, OpenType, and AAT."
HOMEPAGE="https://github.com/harfbuzz/ttf-parser"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"apple-layout"
	"default"
	"glyph-names"
	"gvar-alloc"
	"no-std-float"
	"opentype-layout"
	"std"
	"variable-fonts"
)
