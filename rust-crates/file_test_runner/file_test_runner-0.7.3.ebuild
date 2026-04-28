# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="file_test_runner"
CRATE_VERSION="0.7.3"
CRATE_CHECKSUM="cf50901549edf2241e33d1715aec0575adc5510a09724877a1e0afe7ffafb0fb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="File-based test runner for running tests found in files."
HOMEPAGE="https://github.com/denoland/file_test_runner"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
