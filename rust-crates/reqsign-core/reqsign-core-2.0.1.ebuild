# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-core"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="39da118ccf3bdb067ac6cc40136fec99bc5ba418cbd388dc88e4ce0e5d0b1423"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Signing API requests without effort."
HOMEPAGE="https://github.com/apache/opendal-reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
