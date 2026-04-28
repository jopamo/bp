# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="miow"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="536bfad37a309d62069485248eeaba1e8d9853aaf951caaeaed0585a95346f08"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A zero overhead I/O library for Windows, focusing on IOCP and async I/O abstractions."
HOMEPAGE="https://github.com/yoshuawuyts/miow"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
