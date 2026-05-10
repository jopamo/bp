# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="xmlwriter"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="ec7a2a501ed189703dba8b08142f057e887dfc4b2cc4db2d343ac6376ba3e0b9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple, streaming XML writer."
HOMEPAGE="https://github.com/RazrFalcon/xmlwriter"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
