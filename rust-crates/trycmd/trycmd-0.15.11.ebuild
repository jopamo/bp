# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="trycmd"
CRATE_VERSION="0.15.11"
CRATE_CHECKSUM="a81ea3136ddc88e19c2cc2eb3176b72abee4e831367cd8949f2a88ac5497e64e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Snapshot testing for a herd of CLI tests"
HOMEPAGE="https://github.com/assert-rs/snapbox/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"color"
	"color-auto"
	"debug"
	"default"
	"diff"
	"examples"
	"filesystem"
	"schema"
)
