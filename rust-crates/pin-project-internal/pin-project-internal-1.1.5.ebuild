# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pin-project-internal"
CRATE_VERSION="1.1.5"
CRATE_CHECKSUM="2f38a4412a78282e09a2cf38d195ea5420d15ba0602cb375210efbc877243965"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the `pin-project` crate."
HOMEPAGE="https://github.com/taiki-e/pin-project"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
