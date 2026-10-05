# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rstest_macros"
CRATE_VERSION="0.22.0"
CRATE_CHECKSUM="c5e1711e7d14f74b12a58411c542185ef7fb7f2e7f8ee6e2940a883628522b42"
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
