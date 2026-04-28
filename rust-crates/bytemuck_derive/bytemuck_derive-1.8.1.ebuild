# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bytemuck_derive"
CRATE_VERSION="1.8.1"
CRATE_CHECKSUM="3fa76293b4f7bb636ab88fd78228235b5248b4d05cc589aed610f954af5d7c7a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="derive proc-macros for `bytemuck`"
HOMEPAGE="https://github.com/Lokathor/bytemuck"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
