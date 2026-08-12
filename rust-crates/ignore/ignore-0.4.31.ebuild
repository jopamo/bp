# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ignore"
CRATE_VERSION="0.4.31"
CRATE_CHECKSUM="7f8a7b8211e695a1d0cd91cace480d4d0bd57667ab10277cc412c5f7f4884f83"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast library for efficiently matching ignore files such as \`.gitignore\` against file paths."
HOMEPAGE="https://github.com/BurntSushi/ripgrep/tree/master/crates/ignore"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"simd-accel"
)
