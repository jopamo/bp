# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="svgfilters"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="639abcebc15fdc2df179f37d6f5463d660c1c79cd552c12343a4600827a04bce"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation of various SVG filters."
HOMEPAGE="https://github.com/RazrFalcon/resvg/tree/master/svgfilters"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
