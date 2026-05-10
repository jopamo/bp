# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="test-log-macros"
CRATE_VERSION="0.2.18"
CRATE_CHECKSUM="451b374529930d7601b1eef8d32bc79ae870b6079b069401709c2a8bf9e75f36"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Supporting procedural macro crate for test-log."
HOMEPAGE="https://github.com/d-e-s-o/test-log.git"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"log"
	"trace"
	"unstable"
)
