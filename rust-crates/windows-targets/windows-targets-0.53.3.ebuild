# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-targets"
CRATE_VERSION="0.53.3"
CRATE_CHECKSUM="d5fe6031c4041849d7c496a8ded650796e7b6ecc19df1a431c1a363342e5dc91"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import libs for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
