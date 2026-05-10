# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="supports-hyperlinks"
CRATE_VERSION="3.1.0"
CRATE_CHECKSUM="804f44ed3c63152de6a9f90acbea1a110441de43006ea51bcce8f436196a288b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Detects whether a terminal supports rendering hyperlinks."
HOMEPAGE="https://github.com/zkat/supports-hyperlinks"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
