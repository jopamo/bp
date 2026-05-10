# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tracing-test"
CRATE_VERSION="0.2.6"
CRATE_CHECKSUM="19a4c448db514d4f24c5ddb9f73f2ee71bfb24c526cf0c570ba142d1119e0051"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper functions and macros that allow for easier testing of crates that use \`tracing\`."
HOMEPAGE="https://github.com/dbrgn/tracing-test"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"no-env-filter"
)
