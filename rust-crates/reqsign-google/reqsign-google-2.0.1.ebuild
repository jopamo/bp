# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-google"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="16e1942acf06b8638f16775e92e4ca9cca239519ea6f4e650d5924d1f0dc37d1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Goole Cloud Platform signing implementation for reqsign."
HOMEPAGE="https://github.com/apache/opendal-reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
