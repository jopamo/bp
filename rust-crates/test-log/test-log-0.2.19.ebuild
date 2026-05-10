# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="test-log"
CRATE_VERSION="0.2.19"
CRATE_CHECKSUM="37d53ac171c92a39e4769491c4b4dde7022c60042254b5fc044ae409d34a24d4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A replacement of the #[test] attribute that initializes logging and/or tracing infrastructure before running tests."
HOMEPAGE="https://github.com/d-e-s-o/test-log"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"color"
	"default"
	"log"
	"trace"
	"unstable"
)
