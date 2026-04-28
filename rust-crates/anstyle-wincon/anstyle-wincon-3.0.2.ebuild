# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle-wincon"
CRATE_VERSION="3.0.2"
CRATE_CHECKSUM="1cd54b81ec8d6180e24654d0b371ad22fc3dd083b6ff8ba325b72e00c87660a7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Styling legacy Windows terminals"
HOMEPAGE="https://github.com/rust-cli/anstyle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
