# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crc-catalog"
CRATE_VERSION="2.4.0"
CRATE_CHECKSUM="19d374276b40fb8bbdee95aef7c7fa6b5316ec764510eb64b8dd0e2ed0d7e7f5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Catalog of CRC algorithms (generated from http://reveng.sourceforge.net/crc-catalogue) expressed as simple Rust structs."
HOMEPAGE="https://github.com/akhilles/crc-catalog.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
