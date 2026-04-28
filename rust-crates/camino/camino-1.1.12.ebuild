# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="camino"
CRATE_VERSION="1.1.12"
CRATE_CHECKSUM="dd0b03af37dad7a14518b7691d81acb0f8222604ad3d1b02f6b4bed5188c0cd5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UTF-8 paths"
HOMEPAGE="https://github.com/camino-rs/camino"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"proptest1"
	"serde1"
)
