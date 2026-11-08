# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zip"
CRATE_VERSION="8.6.0"
CRATE_CHECKSUM="2d04a6b5381502aa6087c94c669499eb1602eb9c5e8198e534de571f7154809b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library to support the reading and writing of zip files."
HOMEPAGE="https://github.com/zip-rs/zip2"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_arbitrary"
	"_bzip2_any"
	"_deflate-any"
	"aes-crypto"
	"bzip2"
	"bzip2-rs"
	"chrono"
	"default"
	"deflate"
	"deflate-flate2"
	"deflate-flate2-zlib"
	"deflate-flate2-zlib-ng"
	"deflate-flate2-zlib-ng-compat"
	"deflate-flate2-zlib-rs"
	"deflate-zopfli"
	"deprecated-time"
	"jiff-02"
	"legacy-zip"
	"lzma"
	"nt-time"
	"ppmd"
	"time"
	"unreserved"
	"xz"
)
