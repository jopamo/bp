# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="semver"
CRATE_VERSION="1.0.26"
CRATE_CHECKSUM="56e6fa9c48d24d85fb3de5ad847117517440f6beceb7798af16b4a87d616b8d0"
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
