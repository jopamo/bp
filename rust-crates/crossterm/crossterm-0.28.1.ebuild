# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crossterm"
CRATE_VERSION="0.28.1"
CRATE_CHECKSUM="829d955a0bb380ef178a640b91779e3987da38c9aea133b20614cfed8cdea9c6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crossplatform terminal library for manipulating terminals."
HOMEPAGE="https://github.com/crossterm-rs/crossterm"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"bracketed-paste"
	"default"
	"event-stream"
	"events"
	"serde"
	"use-dev-tty"
	"windows"
)
