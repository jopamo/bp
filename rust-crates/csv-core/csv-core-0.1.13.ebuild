# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="csv-core"
CRATE_VERSION="0.1.13"
CRATE_CHECKSUM="704a3c26996a80471189265814dbc2c257598b96b8a7feae2d31ace646bb9782"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bare bones CSV parsing with no_std support."
HOMEPAGE="https://github.com/BurntSushi/rust-csv"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"libc"
)
