# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tracing-test-macro"
CRATE_VERSION="0.2.6"
CRATE_CHECKSUM="ad06847b7afb65c7866a36664b75c40b895e318cea4f71299f013fb22965329d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A procedural macro that allow for easier testing of crates that use \`tracing\`. Internal crate, should only be used through the \`tracing-test\` crate."
HOMEPAGE="https://github.com/dbrgn/tracing-test"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"no-env-filter"
)
