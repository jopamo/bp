# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="countme"
CRATE_VERSION="3.0.1"
CRATE_CHECKSUM="7704b5fdd17b18ae31c4c1da5a2e0305a2bf17b5249300a9ee9ed7b72114c636"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Counts the number of live instances of types"
HOMEPAGE="https://github.com/matklad/countme"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"enable"
	"print_at_exit"
)
