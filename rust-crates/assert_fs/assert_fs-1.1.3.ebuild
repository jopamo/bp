# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="assert_fs"
CRATE_VERSION="1.1.3"
CRATE_CHECKSUM="a652f6cb1f516886fcfee5e7a5c078b9ade62cfcb889524efe5a64d682dd27a9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Filesystem fixtures and assertions for testing."
HOMEPAGE="https://github.com/assert-rs/assert_fs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"color"
	"color-auto"
)
