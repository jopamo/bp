# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dtoa"
CRATE_VERSION="1.0.10"
CRATE_CHECKSUM="d6add3b8cff394282be81f3fc1a0605db594ed69890078ca6e2cab1c408bcf04"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast floating point primitive to string conversion"
HOMEPAGE="https://github.com/dtolnay/dtoa"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
