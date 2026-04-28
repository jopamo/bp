# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_chacha"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="556d3a1ca6600bfcbab7c7c91ccb085ac7fbbcd70e008a98742e7847f4f7bcef"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ChaCha random number generator"
HOMEPAGE="https://crates.io/crates/rand_chacha"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
