# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="argmax"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="0144c58b55af0133ec3963ce5e4d07aad866e3bbcfdcddbf4590dbd7ad6ff557"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust library to deal with 'argument too long' errors"
HOMEPAGE="https://github.com/sharkdp/argmax"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
