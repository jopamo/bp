# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rdrand"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="678054eb77286b51581ba43620cc911abf02758c91f93f479767aed0f90458b2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of random number generator based on rdrand and rdseed instructions"
HOMEPAGE="https://github.com/nagisa/rust_rdrand/"
LICENSE="ISC"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
