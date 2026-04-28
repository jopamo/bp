# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="convert_case"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="6245d59a3e82a7fc217c5828a6692dbc6dfb63a0c8c90495621f7b9d79704a0e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Convert strings into any case"
HOMEPAGE="https://github.com/rutrum/convert-case"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"random"
)
