# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="semver"
CRATE_VERSION="1.0.28"
CRATE_CHECKSUM="8a7852d02fc848982e0c167ef163aaff9cd91dc640ba85e263cb1ce46fae51cd"
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
