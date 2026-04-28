# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="core-graphics-types"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="45390e6114f68f718cc7a830514a96f903cccd70d02a8f6d9f643ac4ba45afaf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings for some fundamental Core Graphics types"
HOMEPAGE="https://github.com/servo/core-foundation-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"link"
)
