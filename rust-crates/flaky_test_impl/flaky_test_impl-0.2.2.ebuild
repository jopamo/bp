# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="flaky_test_impl"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="85e35909c2f0552fdae5b40f1e95a7da12afb58c1f2f455a12c216c58d869abe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="implementation detail of the \`flaky_test\` macro"
HOMEPAGE="https://github.com/denoland/flaky_test"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
