# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="iana-time-zone"
CRATE_VERSION="0.1.64"
CRATE_CHECKSUM="33e57f83510bb73707521ebaffa789ec8caf86f9657cad665b092b581d40e9fb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="get the IANA time zone for the current system"
HOMEPAGE="https://github.com/strawlab/iana-time-zone"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"fallback"
)
