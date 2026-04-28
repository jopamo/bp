# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pear"
CRATE_VERSION="0.2.9"
CRATE_CHECKSUM="bdeeaa00ce488657faba8ebf44ab9361f9365a97bd39ffb8a60663f57ff4b467"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A pear is a fruit."
HOMEPAGE="https://github.com/SergioBenitez/Pear"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"color"
	"default"
)
