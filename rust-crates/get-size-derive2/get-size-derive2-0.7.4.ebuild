# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="get-size-derive2"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="f2b6d1e2f75c16bfbcd0f95d84f99858a6e2f885c2287d1f5c3a96e8444a34b4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derives the GetSize trait."
HOMEPAGE="https://github.com/bircni/get-size2/tree/main/crates/get-size-derive2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
