# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crc-catalog"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="ccaeedb56da03b09f598226e25e80088cb4cd25f316e6e4df7d695f0feeb1403"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Catalog of CRC algorithms (generated from http://reveng.sourceforge.net/crc-catalogue) expressed as simple Rust structs."
HOMEPAGE="https://github.com/akhilles/crc-catalog.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
