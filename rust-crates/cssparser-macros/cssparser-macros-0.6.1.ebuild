# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cssparser-macros"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="13b588ba4ac1a99f7f2964d24b3d896ddc6bf847ee3855dbd4366f058cfcd331"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros for cssparser"
HOMEPAGE="https://github.com/servo/rust-cssparser"
LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
