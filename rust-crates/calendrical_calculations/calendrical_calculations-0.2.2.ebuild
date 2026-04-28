# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="calendrical_calculations"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="53c5d386a9f2c8b97e1a036420bcf937db4e5c9df33eb0232025008ced6104c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Calendrical calculations in Rust"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"logging"
)
