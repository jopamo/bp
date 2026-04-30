# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="msi"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="b0325f8473ef1f5c38ee42345e2cd1678299cbbfa169d1776654a2a682867420"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Read/write Windows Installer (MSI) files"
HOMEPAGE="https://github.com/mdsteele/rust-msi"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
