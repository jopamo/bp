# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="diplomat_core"
CRATE_VERSION="0.12.1"
CRATE_CHECKSUM="ad619d9fdee0e731bb6f8f7d797b6ecfdc2395e363f554d2f6377155955171eb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared utilities between Diplomat macros and code generation"
HOMEPAGE="https://github.com/rust-diplomat/diplomat"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"hir"
)
