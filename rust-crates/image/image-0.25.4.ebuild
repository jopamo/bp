# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="image"
CRATE_VERSION="0.25.4"
CRATE_CHECKSUM="bc144d44a31d753b02ce64093d532f55ff8dc4ebf2ffb8a63c0dda691385acae"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Imaging library. Provides basic image processing and encoders/decoders for common image formats."
HOMEPAGE="https://github.com/image-rs/image"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
	"tga"
	"tiff"
	"webp"
)
