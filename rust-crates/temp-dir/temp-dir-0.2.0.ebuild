# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="temp-dir"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="016ef9739649996fcc983b9c588fe3d557cf216d4d98503ce1b057ab5a66d689"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Simple temporary directory with cleanup"
HOMEPAGE="https://gitlab.com/leonhard-llc/ops"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
