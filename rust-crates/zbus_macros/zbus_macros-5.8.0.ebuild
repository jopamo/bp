# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zbus_macros"
CRATE_VERSION="5.8.0"
CRATE_CHECKSUM="e5c8e4e14dcdd9d97a98b189cd1220f30e8394ad271e8c987da84f73693862c2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="proc-macros for zbus"
HOMEPAGE="https://github.com/dbus2/zbus/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"blocking-api"
	"default"
	"gvariant"
)
