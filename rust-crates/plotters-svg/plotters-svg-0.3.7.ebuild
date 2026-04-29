# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="plotters-svg"
CRATE_VERSION="0.3.7"
CRATE_CHECKSUM="51bae2ac328883f7acdfea3d66a7c35751187f870bc81f94563733a154d7a670"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Plotters SVG backend"
HOMEPAGE="https://plotters-rs.github.io"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bitmap_encoder"
	"debug"
)
