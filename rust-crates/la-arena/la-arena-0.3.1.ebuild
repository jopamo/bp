# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="la-arena"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="3752f229dcc5a481d60f385fa479ff46818033d881d2d801aa27dffcfb5e8306"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Simple index-based arena without deletion."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer/tree/master/lib/la-arena"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
