# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="platform-info"
CRATE_VERSION="2.2.0"
CRATE_CHECKSUM="ba7c3f5af00d3596a148cc80178ac690152b71c283d15a8bcea0cddfea759a36"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple cross-platform interface to get info about a system"
HOMEPAGE="https://github.com/uutils/platform-info"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
