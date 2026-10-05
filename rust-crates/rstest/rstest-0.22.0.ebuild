# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rstest"
CRATE_VERSION="0.22.0"
CRATE_CHECKSUM="7b423f0e62bdd61734b67cd21ff50871dfaeb9cc74f869dcd6af974fbcb19936"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust fixture based test framework. It use procedural macro to implement fixtures and table based tests."
HOMEPAGE="https://github.com/la10736/rstest"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-timeout"
	"crate-name"
	"default"
)
