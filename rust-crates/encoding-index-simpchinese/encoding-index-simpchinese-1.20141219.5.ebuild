# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encoding-index-simpchinese"
CRATE_VERSION="1.20141219.5"
CRATE_CHECKSUM="d87a7194909b9118fc707194baa434a4e3b0fb6a5a757c73c3adb07aa25031f7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Index tables for simplified Chinese character encodings"
HOMEPAGE="https://github.com/lifthrasiir/rust-encoding"
LICENSE="CC0-1.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
