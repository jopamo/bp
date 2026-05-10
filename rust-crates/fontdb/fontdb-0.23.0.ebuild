# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fontdb"
CRATE_VERSION="0.23.0"
CRATE_CHECKSUM="457e789b3d1202543297a350643cf459f836cade38934e7a4cf6a39e7cde2905"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple, in-memory font database with CSS-like queries."
HOMEPAGE="https://github.com/RazrFalcon/fontdb"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fontconfig"
	"fs"
	"memmap"
	"std"
)
