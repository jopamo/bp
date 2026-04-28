# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="argfile"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="0a1cc0ba69de57db40674c66f7cf2caee3981ddef084388482c95c0e2133e5e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Load additional CLI args from file"
HOMEPAGE="https://github.com/rust-cli/argfile"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"response"
)
