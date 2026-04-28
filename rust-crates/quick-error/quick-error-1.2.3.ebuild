# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quick-error"
CRATE_VERSION="1.2.3"
CRATE_CHECKSUM="a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro which makes error types pleasant to write."
HOMEPAGE="http://github.com/tailhook/quick-error"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
