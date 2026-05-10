# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rust-ini"
CRATE_VERSION="0.21.3"
CRATE_CHECKSUM="796e8d2b6696392a43bea58116b667fb4c29727dc5abd27d6acf338bb4f688c7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An Ini configuration file parsing library in Rust"
HOMEPAGE="https://github.com/zonyitoo/rust-ini"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"brackets-in-section-names"
	"case-insensitive"
	"default"
	"inline-comment"
)
