# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cyclonedx-bom"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="c7f8e9344d60bee3c88033b26d7b233815ae12855bdce5370b66368ae13ac8ac"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="CycloneDX Software Bill of Materials Library"
HOMEPAGE="https://cyclonedx.org/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
