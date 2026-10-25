# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="webpki-roots"
CRATE_VERSION="1.0.10"
CRATE_CHECKSUM="1c1c8e20c8a38fc7d65abfe74eb7280e4aa667e8eec8bc84996d2874810748d9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mozilla's CA root certificates for use with webpki"
HOMEPAGE="https://github.com/rustls/webpki-roots"
LICENSE="CDLA-Permissive-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
