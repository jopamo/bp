# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libsui"
CRATE_VERSION="0.12.6"
CRATE_CHECKSUM="e2b6d6bbf43ba95540d1681826c8d7acb9744708398463ccbcd3c3a5d04c2fdc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A injection tool for executable formats (ELF, PE, Mach-O) that allows you to embed files into existing binary and extract them at runtime"
HOMEPAGE="https://github.com/denoland/sui"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
