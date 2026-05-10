# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="potential_utf"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="e5a7c30837279ca13e7c867e9e40053bc68740f988cb07f7ca6df43cc734b585"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unvalidated string and character types"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"serde"
	"writeable"
	"zerovec"
)
