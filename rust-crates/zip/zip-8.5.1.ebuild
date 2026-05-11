# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zip"
CRATE_VERSION="8.5.1"
CRATE_CHECKSUM="dcab981e19633ebcf0b001ddd37dd802996098bc1864f90b7c5d970ce76c1d59"
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
