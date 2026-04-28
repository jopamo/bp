# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="foreign-types-shared"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An internal crate used by foreign-types"
HOMEPAGE="https://github.com/sfackler/foreign-types"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
