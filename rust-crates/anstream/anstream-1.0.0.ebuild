# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstream"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="824a212faf96e9acacdbd09febd34438f8f711fb84e09a8916013cd7815ca28d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="IO stream adapters for writing colored text that will gracefully degrade according to your terminal's capabilities."
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"auto"
	"default"
	"test"
	"wincon"
)
