# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="selectors"
CRATE_VERSION="0.30.0"
CRATE_CHECKSUM="3df44ba8a7ca7a4d28c589e04f526266ed76b6cc556e33fe69fa25de31939a65"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="CSS Selectors matching for Rust"
HOMEPAGE="https://github.com/servo/stylo"
LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"bench"
	"to_shmem"
)
