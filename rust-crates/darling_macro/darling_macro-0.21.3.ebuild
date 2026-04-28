# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="darling_macro"
CRATE_VERSION="0.21.3"
CRATE_CHECKSUM="d38308df82d1080de0afee5d069fa14b0326a88c14f15c5ccda35b4a6c414c81"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Internal support for a proc-macro library for reading attributes into structs when implementing custom derives. Use https://crates.io/crates/darling in your code."
HOMEPAGE="https://github.com/TedDriggs/darling"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
