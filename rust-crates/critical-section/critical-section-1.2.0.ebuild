# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="critical-section"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="790eea4361631c5e7d22598ecd5723ff611904e3344ce8720784c93e3d83d40b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform critical section"
HOMEPAGE="https://github.com/rust-embedded/critical-section"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"restore-state-bool"
	"restore-state-none"
	"restore-state-u16"
	"restore-state-u32"
	"restore-state-u64"
	"restore-state-u8"
	"restore-state-usize"
	"std"
)
