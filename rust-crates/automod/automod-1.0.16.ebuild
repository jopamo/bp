# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="automod"
CRATE_VERSION="1.0.16"
CRATE_CHECKSUM="e8b5778837666541195063243828c5b6139221b47dc4ec3ba81738e532469ab1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pull in every source file in a directory as a module."
HOMEPAGE="https://github.com/dtolnay/automod"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
