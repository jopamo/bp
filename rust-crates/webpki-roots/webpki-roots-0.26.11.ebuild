# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="webpki-roots"
CRATE_VERSION="0.26.11"
CRATE_CHECKSUM="521bc38abb08001b01866da9f51eb7c5d647a19260e00054a8c7fd5f9e57f7a9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mozilla's CA root certificates for use with webpki"
HOMEPAGE="https://github.com/rustls/webpki-roots"
LICENSE="CDLA-Permissive-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
