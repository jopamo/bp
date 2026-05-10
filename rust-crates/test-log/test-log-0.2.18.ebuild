# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="test-log"
CRATE_VERSION="0.2.18"
CRATE_CHECKSUM="1e33b98a582ea0be1168eba097538ee8dd4bbe0f2b01b22ac92ea30054e5be7b"
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
