# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="async-recursion"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="3b43422f69d8ff38f95f1b2bb76517c91589a924d1559a0e935d7c8ce0274c11"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Recursion for async functions"
HOMEPAGE="https://github.com/dcchut/async-recursion"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
