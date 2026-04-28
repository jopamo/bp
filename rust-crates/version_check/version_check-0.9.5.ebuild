# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="version_check"
CRATE_VERSION="0.9.5"
CRATE_CHECKSUM="0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tiny crate to check the version of the installed/running rustc."
HOMEPAGE="https://github.com/SergioBenitez/version_check"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
