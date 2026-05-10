# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="resvg"
CRATE_VERSION="0.46.0"
CRATE_CHECKSUM="b563218631706d614e23059436526d005b50ab5f2d506b55a17eb65c5eb83419"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An SVG rendering library."
HOMEPAGE="https://github.com/linebender/resvg"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"memmap-fonts"
	"raster-images"
	"system-fonts"
	"text"
)
