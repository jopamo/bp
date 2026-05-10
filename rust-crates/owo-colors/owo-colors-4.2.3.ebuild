# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="owo-colors"
CRATE_VERSION="4.2.3"
CRATE_CHECKSUM="9c6901729fa79e91a0913333229e9ca5dc725089d1c363b2f4b4760709dc4a52"
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
