# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="vte"
CRATE_VERSION="0.15.0"
CRATE_CHECKSUM="a5924018406ce0063cd67f8e008104968b74b563ee1b85dde3ed1f7cb87d3dbd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser for implementing terminal emulators"
HOMEPAGE="https://github.com/alacritty/vte"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ansi"
	"default"
	"serde"
	"std"
)
