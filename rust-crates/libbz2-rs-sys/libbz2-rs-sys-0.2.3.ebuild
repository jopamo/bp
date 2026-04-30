# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libbz2-rs-sys"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="b3a6a8c165077efc8f3a971534c50ea6a1a18b329ef4a66e897a7e3a1494565f"
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
