# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="plotters"
CRATE_VERSION="0.3.7"
CRATE_CHECKSUM="5aeb6f403d7a4911efb1e33402027fc44f29b5bf6def3effcc22d7bb75f2b747"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust drawing library focus on data plotting for both WASM and native applications"
HOMEPAGE="https://plotters-rs.github.io/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ab_glyph"
	"all_elements"
	"all_series"
	"area_series"
	"bitmap_backend"
	"bitmap_encoder"
	"bitmap_gif"
	"boxplot"
	"candlestick"
	"colormaps"
	"datetime"
	"default"
	"deprecated_items"
	"errorbar"
	"evcxr"
	"evcxr_bitmap"
	"fontconfig-dlopen"
	"full_palette"
	"histogram"
	"line_series"
	"point_series"
	"surface_series"
	"svg_backend"
	"ttf"
)
