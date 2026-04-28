# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="id-arena"
CRATE_VERSION="2.3.0"
CRATE_CHECKSUM="3d3067d79b975e8844ca9eb072e16b31c3c1c36928edf9c6789548c524d0d954"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple, id-based arena."
HOMEPAGE="https://github.com/fitzgen/id-arena"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
