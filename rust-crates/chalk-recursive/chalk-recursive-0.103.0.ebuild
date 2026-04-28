# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="chalk-recursive"
CRATE_VERSION="0.103.0"
CRATE_CHECKSUM="c855be60e646664bc37c2496d3dc81ca5ef60520930e5e0f0057a0575aff6c19"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Recursive solver for the Chalk project"
HOMEPAGE="https://github.com/rust-lang/chalk"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"tracing-full"
)
