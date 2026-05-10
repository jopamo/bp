# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="embed-manifest"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="94cdc65b1cf9e871453ce2f86f5aaec24ff2eaa36a1fa3e02e441dddc3613b99"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Build script library to easily embed a Windows manifest."
HOMEPAGE="https://codeberg.org/carey/embed-manifest"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
