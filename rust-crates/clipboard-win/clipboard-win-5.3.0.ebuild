# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clipboard-win"
CRATE_VERSION="5.3.0"
CRATE_CHECKSUM="d517d4b86184dbb111d3556a10f1c8a04da7428d2987bf1081602bf11c3aa9ee"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides simple way to interact with Windows clipboard."
HOMEPAGE="https://github.com/DoumanAsh/clipboard-win"
LICENSE="BSL-1.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"monitor"
	"std"
)
