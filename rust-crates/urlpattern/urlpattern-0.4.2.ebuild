# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="urlpattern"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="0f805818f843b548bacc19609eb3619dd2850e54746f5cada37927393c2ef4ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rust-urlpattern is a Rust implementation of the URLPattern standard"
HOMEPAGE="https://github.com/denoland/rust-urlpattern"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
