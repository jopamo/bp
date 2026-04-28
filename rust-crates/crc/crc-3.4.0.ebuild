# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crc"
CRATE_VERSION="3.4.0"
CRATE_CHECKSUM="5eb8a2a1cd12ab0d987a5d5e825195d372001a4094a0376319d5a0ad71c1ba0d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust implementation of CRC with support of various standards"
HOMEPAGE="https://github.com/mrhooray/crc-rs.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
