# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ungrammar"
CRATE_VERSION="1.16.1"
CRATE_CHECKSUM="a3e5df347f0bf3ec1d670aad6ca5c6a1859cd9ea61d2113125794654ccced68f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A DSL for describing concrete syntax trees"
HOMEPAGE="https://github.com/matklad/ungrammar"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
