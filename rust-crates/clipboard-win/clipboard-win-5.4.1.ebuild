# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clipboard-win"
CRATE_VERSION="5.4.1"
CRATE_CHECKSUM="bde03770d3df201d4fb868f2c9c59e66a3e4e2bd06692a0fe701e7103c7e84d4"
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
