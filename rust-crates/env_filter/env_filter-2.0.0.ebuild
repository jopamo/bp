# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="env_filter"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="900d271a03799a1ee8d1ca9b19893b48ca674a9284fefcfb85f05e74ed314217"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Filter log events using environment variables"
HOMEPAGE="https://github.com/rust-cli/env_logger"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"regex"
	"std"
)
