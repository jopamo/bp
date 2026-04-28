# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="semver"
CRATE_VERSION="1.0.25"
CRATE_CHECKSUM="f79dfe2d285b0488816f30e700a7438c5a73d816b5b7d3ac72fbc48b0d185e03"
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
	"std"
)
