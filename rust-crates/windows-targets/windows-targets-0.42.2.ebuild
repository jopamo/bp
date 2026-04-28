# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-targets"
CRATE_VERSION="0.42.2"
CRATE_CHECKSUM="8e5180c00cd44c9b1c88adb3693291f1cd93605ded80c250a75d472756b4d071"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import libs for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
