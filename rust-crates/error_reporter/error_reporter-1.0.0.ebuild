# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="error_reporter"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="31ae425815400e5ed474178a7a22e275a9687086a12ca63ec793ff292d8fdae8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to print errors"
HOMEPAGE="https://github.com/mahkoh/error_reporter"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
