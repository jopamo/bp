# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustybuzz"
CRATE_VERSION="0.20.1"
CRATE_CHECKSUM="fd3c7c96f8a08ee34eff8857b11b49b07d71d1c3f4e88f8a88d4c9e9f90b1702"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A complete harfbuzz shaping algorithm port to Rust."
HOMEPAGE="https://github.com/harfbuzz/rustybuzz"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"wasm-shaper"
)
