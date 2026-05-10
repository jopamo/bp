# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tracing-test"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="557b891436fe0d5e0e363427fc7f217abf9ccd510d5136549847bdcbcd011d68"
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
