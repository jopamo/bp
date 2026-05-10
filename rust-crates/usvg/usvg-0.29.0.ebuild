# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="usvg"
CRATE_VERSION="0.29.0"
CRATE_CHECKSUM="63b6bb4e62619d9f68aa2d8a823fea2bff302340a1f2d45c264d5b0be170832e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An SVG simplification library."
HOMEPAGE="https://github.com/RazrFalcon/resvg"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
