# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ctrlc"
CRATE_VERSION="3.5.2"
CRATE_CHECKSUM="e0b1fab2ae45819af2d0731d60f2afe17227ebb1a1538a236da84c93e9a60162"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Easy Ctrl-C handler for Rust projects"
HOMEPAGE="https://github.com/Detegr/rust-ctrlc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"termination"
)
