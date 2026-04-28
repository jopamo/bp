# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="async-stream"
CRATE_VERSION="0.3.5"
CRATE_CHECKSUM="cd56dd203fef61ac097dd65721a419ddccb106b2d2b70ba60a6b529f03961a51"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Asynchronous streams using async & await notation"
HOMEPAGE="https://github.com/tokio-rs/async-stream"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
