# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="semver"
CRATE_VERSION="1.0.27"
CRATE_CHECKSUM="d767eb0aabc880b29956c35734170f26ed551a859dbd361d140cdbeca61ab1e2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser and evaluator for Cargo's flavor of Semantic Versioning"
HOMEPAGE="https://github.com/dtolnay/semver"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
)
