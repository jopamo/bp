# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="colored"
CRATE_VERSION="2.2.0"
CRATE_CHECKSUM="117725a109d387c937a1533ce01b450cbde6b88abceea8473c4d7a85853cda3c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The most simple way to add colors in your terminal"
HOMEPAGE="https://github.com/mackwic/colored"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"no-color"
)
