# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="image"
CRATE_VERSION="0.25.6"
CRATE_CHECKSUM="db35664ce6b9810857a38a906215e75a9c879f0696556a39f59c62829710251a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Imaging library. Provides basic image processing and encoders/decoders for common image formats."
HOMEPAGE="https://github.com/image-rs/image"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"avif"
	"avif-native"
	"benchmarks"
	"bmp"
	"color_quant"
	"dds"
	"default"
	"default-formats"
	"exr"
	"ff"
	"gif"
	"hdr"
	"ico"
	"jpeg"
	"nasm"
	"png"
	"pnm"
	"qoi"
	"rayon"
	"serde"
	"tga"
	"tiff"
	"webp"
)
