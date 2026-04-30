# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zlib-rs"
CRATE_VERSION="0.6.3"
CRATE_CHECKSUM="3be3d40e40a133f9c916ee3f9f4fa2d9d63435b5fbe1bfc6d9dae0aa0ada1513"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A memory-safe zlib implementation written in rust"
HOMEPAGE="https://github.com/trifectatechfoundation/zlib-rs"
LICENSE="Zlib"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ZLIB_DEBUG"
	"__internal-api"
	"__internal-fuzz"
	"__internal-fuzz-disable-checksum"
	"__internal-test"
	"avx512"
	"c-allocator"
	"default"
	"rust-allocator"
	"std"
	"vpclmulqdq"
)
