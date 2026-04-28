# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="webpki-root-certs"
CRATE_VERSION="0.26.6"
CRATE_CHECKSUM="e8c6dfa3ac045bc517de14c7b1384298de1dbd229d38e08e169d9ae8c170937c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mozilla trusted certificate authorities in self-signed X.509 format for use with crates other than webpki"
HOMEPAGE="https://github.com/rustls/webpki-roots"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
