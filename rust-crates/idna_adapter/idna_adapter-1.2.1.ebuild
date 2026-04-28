# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="idna_adapter"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="3acae9609540aa318d1bc588455225fb2085b9ed0c4f6bd0d9d5bcd86f1a0344"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Back end adapter for idna"
HOMEPAGE="https://docs.rs/crate/idna_adapter/latest"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"compiled_data"
)
