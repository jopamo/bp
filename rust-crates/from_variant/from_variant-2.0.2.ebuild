# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="from_variant"
CRATE_VERSION="2.0.2"
CRATE_CHECKSUM="308530a56b099da144ebc5d8e179f343ad928fa2b3558d1eb3db9af18d6eff43"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically derive From impls for enums"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
