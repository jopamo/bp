# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="snapbox-macros"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="3b750c344002d7cc69afb9da00ebd9b5c0f8ac2eb7d115d9d45d5b5f47718d74"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Snapshot testing toolbox"
HOMEPAGE="https://github.com/assert-rs/snapbox/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"color"
	"debug"
	"default"
)
