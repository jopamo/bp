# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle-query"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="e28923312444cdd728e4738b3f9c9cac739500909bb3d3c94b43551b16517648"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Look up colored console capabilities"
HOMEPAGE="https://github.com/rust-cli/anstyle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
