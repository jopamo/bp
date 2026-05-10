# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="webpki-roots"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="7e8983c3ab33d6fb807cfcdad2491c4ea8cbc8ed839181c7dfd9c67c83e261b2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mozilla's CA root certificates for use with webpki"
HOMEPAGE="https://github.com/rustls/webpki-roots"
LICENSE="CDLA-Permissive-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
