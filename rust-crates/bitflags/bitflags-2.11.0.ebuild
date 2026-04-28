# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bitflags"
CRATE_VERSION="2.11.0"
CRATE_CHECKSUM="843867be96c8daad0d758b57df9392b6d8d271134fce549de6ce169ff98a92af"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro to generate structures which behave like bitflags."
HOMEPAGE="https://github.com/bitflags/bitflags"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"example_generated"
	"serde"
	"std"
)
