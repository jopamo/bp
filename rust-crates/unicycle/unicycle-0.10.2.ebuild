# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicycle"
CRATE_VERSION="0.10.2"
CRATE_CHECKSUM="53ccbaf192caef9a758b9cd7ea2e5d98ffd0e40eb62e5e3fbaa50049df8b841f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A scheduler for driving a large number of futures."
HOMEPAGE="https://github.com/udoprog/unicycle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"futures-rs"
	"parking-lot"
)
