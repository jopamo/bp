# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_hc"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="7b40677c7be09ae76218dc623efbf7b18e34bced3f38883af07bb75630a21bc4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="HC128 random number generator"
HOMEPAGE="https://crates.io/crates/rand_hc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
