# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ordered-stream"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="9aa2b01e1d916879f73a53d01d1d6cee68adbb31d6d9177a8cfce093cced1d50"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Streams that are ordered relative to external events"
HOMEPAGE="https://github.com/danieldg/ordered-stream"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
