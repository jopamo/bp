# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fontdb"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="ff20bef7942a72af07104346154a70a70b089c572e454b41bef6eb6cb10e9c06"
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
