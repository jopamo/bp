# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zip"
CRATE_VERSION="2.4.2"
CRATE_CHECKSUM="fabe6324e908f85a1c52063ce7aa26b68dcb7eb6dbc83a2d148403c9bc3eba50"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library to support the reading and writing of zip files."
HOMEPAGE="https://github.com/zip-rs/zip2.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_all-features"
	"_deflate-any"
	"aes-crypto"
	"chrono"
	"default"
	"deflate"
	"deflate-flate2"
	"deflate-miniz"
	"deflate-zlib"
	"deflate-zlib-ng"
	"deflate-zopfli"
	"lzma"
	"nt-time"
	"unreserved"
	"xz"
)
