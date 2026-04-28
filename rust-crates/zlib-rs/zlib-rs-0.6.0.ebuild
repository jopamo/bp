# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zlib-rs"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="a7948af682ccbc3342b6e9420e8c51c1fe5d7bf7756002b4a3c6cabfe96a7e3c"
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
