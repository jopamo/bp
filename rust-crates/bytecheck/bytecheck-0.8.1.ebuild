# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bytecheck"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="50690fb3370fb9fe3550372746084c46f2ac8c9685c583d2be10eefd89d3d1a3"
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
