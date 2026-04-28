# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="flaky_test"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="046caa1f23d7f751fc4ead3d6669a77fa5fc6cf6074960ddeb6a0b0a5b83c8da"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="atttribute macro for running a flaky test multiple times"
HOMEPAGE="https://github.com/denoland/flaky_test"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
