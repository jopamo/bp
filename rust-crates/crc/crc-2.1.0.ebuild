# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crc"
CRATE_VERSION="2.1.0"
CRATE_CHECKSUM="49fc9a695bca7f35f5f4c15cddc84415f66a74ea78eef08e90c5024f2b540e23"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust implementation of CRC(16, 32, 64) with support of various standards"
HOMEPAGE="https://github.com/mrhooray/crc-rs.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
