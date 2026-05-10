# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zlib-rs"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="626bd9fa9734751fc50d6060752170984d7053f5a39061f524cda68023d4db8a"
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
	"__internal-fuzz"
	"__internal-fuzz-disable-checksum"
	"__internal-test"
	"c-allocator"
	"default"
	"rust-allocator"
	"std"
)
