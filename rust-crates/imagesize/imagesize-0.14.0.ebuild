# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="imagesize"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="09e54e57b4c48b40f7aec75635392b12b3421fa26fe8b4332e63138ed278459c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Quick probing of image dimensions without loading the entire file."
HOMEPAGE="https://github.com/Roughsketch/imagesize"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aesprite"
	"bmp"
	"dds"
	"default"
	"exr"
	"farbfeld"
	"gif"
	"hdr"
	"heif"
	"ico"
	"ilbm"
	"jpeg"
	"jxl"
	"ktx2"
	"mod"
	"png"
	"pnm"
	"psd"
	"qoi"
	"tga"
	"tiff"
	"vtf"
	"webp"
)
