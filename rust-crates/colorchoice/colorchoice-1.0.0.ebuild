# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="colorchoice"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="acbf1af155f9b9ef647e42cdc158db4b64a1b61f743629225fde6f3e0be2a7c7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Global override of color control"
HOMEPAGE="https://github.com/rust-cli/anstyle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
