# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rusticata-macros"
CRATE_VERSION="4.1.0"
CRATE_CHECKSUM="faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper macros for Rusticata"
HOMEPAGE="https://github.com/rusticata/rusticata-macros"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
