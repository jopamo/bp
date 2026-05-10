# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="usvg-text-layout"
CRATE_VERSION="0.29.0"
CRATE_CHECKSUM="195386e01bc35f860db024de275a76e7a31afdf975d18beb6d0e44764118b4db"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An SVG text layout implementation."
HOMEPAGE="https://github.com/RazrFalcon/resvg"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"memmap-fonts"
	"system-fonts"
)
