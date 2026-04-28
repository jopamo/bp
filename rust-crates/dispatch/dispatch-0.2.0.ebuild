# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dispatch"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="bd0c93bb4b0c6d9b77f4435b0ae98c24d17f1c45b2ff844c6151a07256ca923b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust wrapper for Apple's Grand Central Dispatch."
HOMEPAGE="http://github.com/SSheldon/rust-dispatch"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
