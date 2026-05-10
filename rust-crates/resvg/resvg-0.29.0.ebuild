# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="resvg"
CRATE_VERSION="0.29.0"
CRATE_CHECKSUM="76888219c0881e22b0ceab06fddcfe83163cd81642bd60c7842387f9c968a72e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An SVG rendering library."
HOMEPAGE="https://github.com/RazrFalcon/resvg"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"filter"
	"memmap-fonts"
	"raster-images"
	"system-fonts"
	"text"
)
