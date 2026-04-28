# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerovec-derive"
CRATE_VERSION="0.11.1"
CRATE_CHECKSUM="5b96237efa0c878c64bd89c436f661be4e46b2f3eff1ebb976f7ef2321d2f58f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for the zerovec crate"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
