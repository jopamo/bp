# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bytecheck"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="26333eeac754f0ad8a6bcd0eb0ac012156302e4e16b852b72ee399aea4f12c29"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Memory validation framework for Rust"
HOMEPAGE="https://github.com/rkyv/bytecheck"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
