# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle-wincon"
CRATE_VERSION="3.0.11"
CRATE_CHECKSUM="291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Styling legacy Windows terminals"
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
