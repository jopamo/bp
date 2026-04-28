# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="halfbrown"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="8588661a8607108a5ca69cab034063441a0413a0b041c13618a7dd348021ef6f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Multi backend HashMap for higher performance on different key space sizes"
HOMEPAGE="https://github.com/Licenser/halfbrown"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"arraybackend"
	"default"
	"fxhash"
)
