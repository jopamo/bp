# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fallible-streaming-iterator"
CRATE_VERSION="0.1.9"
CRATE_CHECKSUM="7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fallible streaming iteration"
HOMEPAGE="https://github.com/sfackler/fallible-streaming-iterator"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
