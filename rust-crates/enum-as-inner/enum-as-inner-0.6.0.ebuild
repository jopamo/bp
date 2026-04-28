# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="enum-as-inner"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="5ffccbb6966c05b32ef8fbac435df276c4ae4d3dc55a8cd0eb9745e6c12f546a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A proc-macro for deriving inner field accessor functions on enums."
HOMEPAGE="https://github.com/bluejekyll/enum-as-inner"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
