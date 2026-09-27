# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra-ap-rustc_pattern_analysis"
CRATE_VERSION="0.166.0"
CRATE_CHECKSUM="42ca286f90e99bb97cd9274c088f3c874a05d1ee90cabf40a3928afedabe99fd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package \`rustc_pattern_analysis\` in the rust-lang/rust repository from commit ce89c898570852a1bb441d77570596e50bf362c2 The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"rustc"
)
