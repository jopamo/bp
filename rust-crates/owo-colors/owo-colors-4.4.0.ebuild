# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="owo-colors"
CRATE_VERSION="4.4.0"
CRATE_CHECKSUM="13c45bb4a6ae1280ec0803b1ef9d3455eb50f01efbbe1447ab020f1d54fba9d8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zero-allocation terminal colors that'll make people go owo"
HOMEPAGE="https://github.com/owo-colors/owo-colors"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"supports-colors"
)
