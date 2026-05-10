# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-http-send-reqwest"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="46186bce769674f9200ad01af6f2ca42de3e819ddc002fff1edae135bfb6cd9c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Reqwest-based HTTP client implementation for reqsign."
HOMEPAGE="https://github.com/apache/opendal-reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
