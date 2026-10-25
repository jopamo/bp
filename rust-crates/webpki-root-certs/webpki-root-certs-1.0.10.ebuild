# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="webpki-root-certs"
CRATE_VERSION="1.0.10"
CRATE_CHECKSUM="58ec80e73fd8baf57bf0d9615554c75348bda990d6d5bbeab964dd068319fecb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mozilla trusted certificate authorities in self-signed X.509 format for use with crates other than webpki"
HOMEPAGE="https://github.com/rustls/webpki-roots"
LICENSE="CDLA-Permissive-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
