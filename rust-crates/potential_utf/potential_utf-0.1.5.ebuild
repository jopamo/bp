# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="potential_utf"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="0103b1cef7ec0cf76490e969665504990193874ea05c85ff9bab8b911d0a0564"
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
	"default"
	"serde"
	"writeable"
	"zerovec"
)
