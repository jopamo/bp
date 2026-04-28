# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="humantime"
CRATE_VERSION="2.1.0"
CRATE_CHECKSUM="9a3a5bfb195931eeb336b2a7b4d761daec841b97f947d34394601737a7bba5e4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A parser and formatter for std::time::{Duration, SystemTime}"
HOMEPAGE="https://github.com/tailhook/humantime"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
