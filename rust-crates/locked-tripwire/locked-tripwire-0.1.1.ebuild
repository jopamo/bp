# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="locked-tripwire"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="d18841f136ee0993c6637a1387eb3758acc9fa24d558f540d329b2d8bb901c67"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Prevent cargo installs without --locked (okay version)"
HOMEPAGE="https://github.com/nextest-rs/locked-tripwire"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nextest"
)
