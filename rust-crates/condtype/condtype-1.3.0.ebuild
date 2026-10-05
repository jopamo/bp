# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="condtype"
CRATE_VERSION="1.3.0"
CRATE_CHECKSUM="baf0a07a401f374238ab8e2f11a104d2851bf9ce711ec69804834de8af45c7af"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Choose types at compile-time via boolean constants."
HOMEPAGE="https://github.com/nvzqz/condtype"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
