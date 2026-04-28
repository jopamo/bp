# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="vte"
CRATE_VERSION="0.13.1"
CRATE_CHECKSUM="9a0b683b20ef64071ff03745b14391751f6beab06a54347885459b77a3f2caa5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser for implementing terminal emulators"
HOMEPAGE="https://github.com/alacritty/vte"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ansi"
	"default"
	"nightly"
	"no_std"
	"serde"
)
