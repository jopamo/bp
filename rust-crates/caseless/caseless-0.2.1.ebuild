# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="caseless"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="808dab3318747be122cb31d36de18d4d1c81277a76f8332a02b81a3d73463d7f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unicode caseless matching"
HOMEPAGE="https://github.com/SimonSapin/rust-caseless"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
