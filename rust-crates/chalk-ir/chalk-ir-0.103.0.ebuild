# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="chalk-ir"
CRATE_VERSION="0.103.0"
CRATE_CHECKSUM="90a37d2ab99352b4caca135061e7b4ac67024b648c28ed0b787feec4bea4caed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Chalk's internal representation of types, goals, and clauses"
HOMEPAGE="https://github.com/rust-lang/chalk"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
