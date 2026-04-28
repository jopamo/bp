# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-interface"
CRATE_VERSION="0.58.0"
CRATE_CHECKSUM="053c4c462dc91d3b1504c6fe5a726dd15e216ba718e84a0e46a88fbe5ded3515"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The interface macro for the windows crate"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
