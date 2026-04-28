# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unic-common"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="80d7ff825a6a654ee85a63e80f92f054f904f21e7d12da4e22f9834a4aaa35bc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UNIC — Common Utilities"
HOMEPAGE="https://github.com/open-i18n/rust-unic/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"unstable"
)
