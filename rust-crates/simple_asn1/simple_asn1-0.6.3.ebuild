# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="simple_asn1"
CRATE_VERSION="0.6.3"
CRATE_CHECKSUM="297f631f50729c8c99b84667867963997ec0b50f32b2a7dbcab828ef0541e8bb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple DER/ASN.1 encoding/decoding library."
HOMEPAGE="https://github.com/acw/simple_asn1"
LICENSE="ISC"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
