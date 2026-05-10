# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zvariant"
CRATE_VERSION="5.6.0"
CRATE_CHECKSUM="d91b3680bb339216abd84714172b5138a4edac677e641ef17e1d8cb1b3ca6e6f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="D-Bus & GVariant encoding & decoding"
HOMEPAGE="https://github.com/dbus2/zbus/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"camino"
	"default"
	"gvariant"
	"option-as-array"
	"ostree-tests"
)
