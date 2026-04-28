# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="humantime-serde"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="57a3db5ea5923d99402c94e9feb261dc5ee9b4efa158b0315f788cf549cc200c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde support for the \`humantime\` crate"
HOMEPAGE="https://github.com/jean-airoldie/humantime-serde"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
