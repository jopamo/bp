# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="proc-macro-utils"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="eeaf08a13de400bc215877b5bdc088f241b12eb42f0a548d3390dc1c56bb7071"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="low-level utilities on proc-macro and proc-macro2 types"
HOMEPAGE="https://github.com/ModProg/proc-macro-utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"parser"
	"proc-macro"
)
