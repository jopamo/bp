# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="expect-test"
CRATE_VERSION="1.5.1"
CRATE_CHECKSUM="63af43ff4431e848fb47472a920f14fa71c24de13255a5692e93d4e90302acb0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimalistic snapshot testing library"
HOMEPAGE="https://github.com/rust-analyzer/expect-test"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
