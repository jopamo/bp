# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="svg"
CRATE_VERSION="0.18.0"
CRATE_CHECKSUM="94afda9cd163c04f6bee8b4bf2501c91548deae308373c436f36aeff3cf3c4a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The package provides an SVG composer and parser."
HOMEPAGE="https://github.com/bodoni/svg"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
