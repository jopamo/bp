# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="salsa-macro-rules"
CRATE_VERSION="0.23.0"
CRATE_CHECKSUM="2edb86a7e9c91f6d30c9ce054312721dbe773a162db27bbfae834d16177b30ce"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Declarative macros for the salsa crate"
HOMEPAGE="https://github.com/salsa-rs/salsa"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
