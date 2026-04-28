# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="plain"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="b4596b6d070b27117e987119b4dac604f3c58cfb0b191112e24771b2faeac1a6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A small Rust library that allows users to reinterpret data of certain types safely."
HOMEPAGE="https://github.com/randomites/plain"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
