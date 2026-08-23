# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cov-mark"
CRATE_VERSION="2.2.0"
CRATE_CHECKSUM="90863d8442510cddf7f46618c4f92413774635771a3e80830c8b30d183420b14"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Manual coverage marks."
HOMEPAGE="https://github.com/matklad/cov-mark"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"enable"
)
