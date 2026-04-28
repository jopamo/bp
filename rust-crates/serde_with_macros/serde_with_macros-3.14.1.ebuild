# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_with_macros"
CRATE_VERSION="3.14.1"
CRATE_CHECKSUM="327ada00f7d64abaac1e55a6911e90cf665aa051b9a561c7006c157f4633135e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="proc-macro library for serde_with"
HOMEPAGE="https://github.com/jonasbb/serde_with/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"schemars_0_8"
	"schemars_0_9"
	"schemars_1"
)
