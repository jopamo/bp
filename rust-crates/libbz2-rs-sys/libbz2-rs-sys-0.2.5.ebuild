# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libbz2-rs-sys"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="34b357333733e8260735ba5894eb928c02ecc69c78715f01a8019e7fa7f2db4c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="a drop-in compatible rust bzip2 implementation"
HOMEPAGE="https://github.com/trifectatechfoundation/libbzip2-rs"
LICENSE="bzip2-1.0.6"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__internal-fuzz-disable-checksum"
	"c-allocator"
	"custom-prefix"
	"default"
	"export-symbols"
	"rust-allocator"
	"semver-prefix"
	"std"
	"stdio"
	"testing-prefix"
)
