# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="smawk"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="b7c388c1b5e93756d0c740965c41e8822f866621d41acbdf6336a6a168f8840c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Functions for finding row-minima in a totally monotone matrix."
HOMEPAGE="https://github.com/mgeisler/smawk"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
