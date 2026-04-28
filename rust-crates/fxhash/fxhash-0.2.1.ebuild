# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fxhash"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="c31b6d751ae2c7f11320402d34e41349dd1016f8d5d45e48c4312bc8625af50c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast, non-secure, hashing algorithm derived from an internal hasher used in FireFox and Rustc."
HOMEPAGE="https://github.com/cbreeden/fxhash"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
