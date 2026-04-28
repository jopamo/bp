# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zip"
CRATE_VERSION="8.1.0"
CRATE_CHECKSUM="6e499faf5c6b97a0d086f4a8733de6d47aee2252b8127962439d8d4311a73f72"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library to support the reading and writing of zip files."
HOMEPAGE="https://github.com/zip-rs/zip2.git"
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
