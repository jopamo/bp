# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="gethostname"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="fc257fdb4038301ce4b9cd1b3b51704509692bb3ff716a410cbd07925d9dae55"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="gethostname for all platforms"
HOMEPAGE="https://codeberg.org/swsnr/gethostname.rs"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
