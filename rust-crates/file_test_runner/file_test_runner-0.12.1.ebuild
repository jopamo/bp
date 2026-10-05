# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="file_test_runner"
CRATE_VERSION="0.12.1"
CRATE_CHECKSUM="aab2ea62262e650557af93e48bfb0ffbcf3b6d86af4b9fea1aa00f93821b69a9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="File-based test runner for running tests found in files."
HOMEPAGE="https://github.com/denoland/file_test_runner"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
