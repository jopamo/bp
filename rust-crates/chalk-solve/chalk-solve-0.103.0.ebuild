# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="chalk-solve"
CRATE_VERSION="0.103.0"
CRATE_CHECKSUM="477ac6cdfd2013e9f93b09b036c2b607a67b2e728f4777b8422d55a79e9e3a34"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Combines the chalk-engine with chalk-ir"
HOMEPAGE="https://github.com/rust-lang/chalk"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"tracing-full"
)
