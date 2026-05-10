# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-file-read-tokio"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="669ea66036266a9ac371d2e63cc7d345e69994da0168b4e6f3487fe21e126f76"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tokio-based file reader implementation for reqsign"
HOMEPAGE="https://github.com/apache/opendal-reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
