# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerocopy"
CRATE_VERSION="0.8.25"
CRATE_CHECKSUM="a1702d9583232ddb9174e01bb7c15a2ab8fb1bc6f227aa1233858c351a3ba0cb"
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
