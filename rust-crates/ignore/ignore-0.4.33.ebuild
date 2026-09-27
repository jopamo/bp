# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ignore"
CRATE_VERSION="0.4.33"
CRATE_CHECKSUM="00b69833ed729dc5aa7d19541d96d6cf8e9137194207a04916d658e43168402f"
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
