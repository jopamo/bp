# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tokio-eld"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="9166030f05d6bc5642bdb8f8c2be31eb3c02cd465d662bcdc2df82d4aa41a584"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Histogram-based sampler for recording and analyzing event loop delays"
HOMEPAGE="https://crates.io/crates/tokio-eld"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
