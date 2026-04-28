# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libbz2-rs-sys"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="2c4a545a15244c7d945065b5d392b2d2d7f21526fba56ce51467b06ed445e8f7"
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
