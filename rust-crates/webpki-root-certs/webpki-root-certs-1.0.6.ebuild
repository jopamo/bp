# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="webpki-root-certs"
CRATE_VERSION="1.0.6"
CRATE_CHECKSUM="804f18a4ac2676ffb4e8b5b5fa9ae38af06df08162314f96a68d2a363e21a8ca"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mozilla trusted certificate authorities in self-signed X.509 format for use with crates other than webpki"
HOMEPAGE="https://github.com/rustls/webpki-roots"
LICENSE="CDLA-Permissive-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
