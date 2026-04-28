# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="urlencoding"
CRATE_VERSION="2.1.3"
CRATE_CHECKSUM="daf8dba3b7eb870caf1ddeed7bc9d2a049f3cfdfae7cb521b087cc33ae4c49da"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust library for doing URL percentage encoding."
HOMEPAGE="https://lib.rs/urlencoding"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
