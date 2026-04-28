# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="termcolor"
CRATE_VERSION="1.4.1"
CRATE_CHECKSUM="06794f8f6c5c898b3275aebefa6b8a1cb24cd2c6c79397ab15774837a0bc5755"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple cross platform library for writing colored text to a terminal."
HOMEPAGE="https://github.com/BurntSushi/termcolor"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
