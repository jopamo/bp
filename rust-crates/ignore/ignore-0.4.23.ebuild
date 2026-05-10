# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ignore"
CRATE_VERSION="0.4.23"
CRATE_CHECKSUM="6d89fd380afde86567dfba715db065673989d6253f42b88179abd3eae47bda4b"
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
