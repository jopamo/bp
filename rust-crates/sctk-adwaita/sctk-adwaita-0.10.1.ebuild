# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sctk-adwaita"
CRATE_VERSION="0.10.1"
CRATE_CHECKSUM="b6277f0217056f77f1d8f49f2950ac6c278c0d607c45f5ee99328d792ede24ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Adwaita-like SCTK Frame"
HOMEPAGE="https://github.com/PolyMeilex/sctk-adwaita"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ab_glyph"
	"crossfont"
	"default"
)
