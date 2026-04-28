# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="foreign-types-shared"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="aa9a19cbb55df58761df49b23516a86d432839add4af60fc256da840f66ed35b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An internal crate used by foreign-types"
HOMEPAGE="https://github.com/sfackler/foreign-types"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
