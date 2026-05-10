# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ttf-parser"
CRATE_VERSION="0.18.1"
CRATE_CHECKSUM="0609f771ad9c6155384897e1df4d948e692667cc0588548b68eb44d052b27633"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A high-level, safe, zero-allocation TrueType font parser."
HOMEPAGE="https://github.com/RazrFalcon/ttf-parser"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"apple-layout"
	"default"
	"glyph-names"
	"gvar-alloc"
	"opentype-layout"
	"std"
	"variable-fonts"
)
