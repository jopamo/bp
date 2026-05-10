# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tracing-test-macro"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="04659ddb06c87d233c566112c1c9c5b9e98256d9af50ec3bc9c8327f873a7568"
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
