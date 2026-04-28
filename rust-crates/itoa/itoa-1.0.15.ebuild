# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="itoa"
CRATE_VERSION="1.0.15"
CRATE_CHECKSUM="4a5f13b858c8d314ee3e8f639011f7ccefe71f97f96e50151fb991f267928e2c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast integer primitive to string conversion"
HOMEPAGE="https://github.com/dtolnay/itoa"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
