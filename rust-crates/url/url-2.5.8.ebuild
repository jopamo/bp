# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="url"
CRATE_VERSION="2.5.8"
CRATE_CHECKSUM="ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="URL library for Rust, based on the WHATWG URL Standard"
HOMEPAGE="https://github.com/servo/rust-url"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debugger_visualizer"
	"default"
	"expose_internals"
	"serde"
	"std"
)
