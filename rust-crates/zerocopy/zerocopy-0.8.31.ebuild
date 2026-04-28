# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerocopy"
CRATE_VERSION="0.8.31"
CRATE_CHECKSUM="fd74ec98b9250adb3ca554bdde269adf631549f51d8a8f8f0a10b50f1cb298c3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zerocopy makes zero-cost memory manipulation effortless. We write \"unsafe\" so you don't have to."
HOMEPAGE="https://github.com/google/zerocopy"
LICENSE="|| ( BSD-2-Clause Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__internal_use_only_features_that_work_on_stable"
	"alloc"
	"derive"
	"float-nightly"
	"simd"
	"simd-nightly"
	"std"
)
