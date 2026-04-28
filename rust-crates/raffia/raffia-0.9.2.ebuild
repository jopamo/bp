# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="raffia"
CRATE_VERSION="0.9.2"
CRATE_CHECKSUM="fffe6643ba09b12af3816c6d3687d8c16c8a306bdbf60e2804b4bbd2c1f5447e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="One parser for CSS/SCSS/Sass/Less."
HOMEPAGE="https://github.com/g-plane/raffia"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"config_serde"
	"serialize"
)
