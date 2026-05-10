# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zvariant_derive"
CRATE_VERSION="5.6.0"
CRATE_CHECKSUM="3a8c68501be459a8dbfffbe5d792acdd23b4959940fc87785fb013b32edbc208"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="D-Bus & GVariant encoding & decoding"
HOMEPAGE="https://github.com/dbus2/zbus/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"gvariant"
)
