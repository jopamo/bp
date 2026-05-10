# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="usvg"
CRATE_VERSION="0.46.0"
CRATE_CHECKSUM="e419dff010bb12512b0ae9e3d2f318dfbdf0167fde7eb05465134d4e8756076f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An SVG simplification library."
HOMEPAGE="https://github.com/linebender/resvg"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"memmap-fonts"
	"system-fonts"
	"text"
)
