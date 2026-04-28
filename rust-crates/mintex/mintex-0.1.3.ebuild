# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="mintex"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="9bec4598fddb13cc7b528819e697852653252b760f1228b7642679bf2ff2cd07"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="minimal mutex"
HOMEPAGE="https://github.com/garypen/mintex"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
