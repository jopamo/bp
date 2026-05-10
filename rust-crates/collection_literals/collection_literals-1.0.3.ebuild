# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="collection_literals"
CRATE_VERSION="1.0.3"
CRATE_CHECKSUM="2550f75b8cfac212855f6b1885455df8eaee8fe8e246b647d69146142e016084"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Easy-to-use macros for initializing any collection"
HOMEPAGE="https://github.com/staedoix/collection_literals"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
