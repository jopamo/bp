# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_config_macro"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="7b416e8ce6de17dc5ea496e10c7012b35bbc0e3fef38d2e065eed936490db0b3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros to prevent mistakes"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
