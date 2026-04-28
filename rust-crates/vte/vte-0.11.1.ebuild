# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="vte"
CRATE_VERSION="0.11.1"
CRATE_CHECKSUM="f5022b5fbf9407086c180e9557be968742d839e68346af7792b8592489732197"
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
