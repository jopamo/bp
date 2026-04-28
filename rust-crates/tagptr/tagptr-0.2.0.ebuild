# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tagptr"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="7b2093cf4c8eb1e67749a6762251bc9cd836b6fc171623bd0a9d324d37af2417"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Strongly typed atomic and non-atomic tagged pointers"
HOMEPAGE="https://github.com/oliver-giersch/tagptr.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
