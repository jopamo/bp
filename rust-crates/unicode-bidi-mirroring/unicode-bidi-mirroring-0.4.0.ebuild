# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-bidi-mirroring"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="5dfa6e8c60bb66d49db113e0125ee8711b7647b5579dc7f5f19c42357ed039fe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unicode Bidi Mirroring property detection"
HOMEPAGE="https://github.com/RazrFalcon/unicode-bidi-mirroring"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
