# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zip"
CRATE_VERSION="7.2.0"
CRATE_CHECKSUM="c42e33efc22a0650c311c2ef19115ce232583abbe80850bc8b66509ebef02de0"
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
	"jiff-02"
	"legacy-zip"
	"lzma"
	"nt-time"
	"ppmd"
	"unreserved"
	"xz"
)
