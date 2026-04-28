# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pin-project-internal"
CRATE_VERSION="1.1.10"
CRATE_CHECKSUM="6e918e4ff8c4549eb882f14b3a4bc8c8bc93de829416eacf579f1207a8fbf861"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the `pin-project` crate."
HOMEPAGE="https://github.com/taiki-e/pin-project"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
