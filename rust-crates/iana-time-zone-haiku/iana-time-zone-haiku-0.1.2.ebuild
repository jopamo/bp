# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="iana-time-zone-haiku"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="iana-time-zone support crate for Haiku OS"
HOMEPAGE="https://github.com/strawlab/iana-time-zone"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
