# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cyclonedx-bom"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="ce2ec98a191e17f63b92b132f6852462de9eaee03ca8dbf2df401b9fd809bcac"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="CycloneDX Software Bill of Materials Library"
HOMEPAGE="https://cyclonedx.org/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
