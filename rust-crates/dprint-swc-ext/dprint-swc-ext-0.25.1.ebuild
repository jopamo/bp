# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dprint-swc-ext"
CRATE_VERSION="0.25.1"
CRATE_CHECKSUM="cf592ae6a864437e98ef9c6ae7936b822077e9d038a3a48ee081ab92313afad4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Functionality to make swc easier to work with."
HOMEPAGE="https://github.com/dprint/dprint-swc-ext"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"sourcemap"
	"view"
)
