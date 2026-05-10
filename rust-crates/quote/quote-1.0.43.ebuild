# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="quote"
CRATE_VERSION="1.0.43"
CRATE_CHECKSUM="dc74d9a594b72ae6656596548f56f667211f8a97b3d4c3d467150794690dc40a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Quasi-quoting macro quote!(...)"
HOMEPAGE="https://github.com/dtolnay/quote"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"proc-macro"
)
