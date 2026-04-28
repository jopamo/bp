# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zip"
CRATE_VERSION="4.6.1"
CRATE_CHECKSUM="caa8cd6af31c3b31c6631b8f483848b91589021b28fffe50adada48d4f4d2ed1"
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
	"deflate-flate2-zlib"
	"deflate-flate2-zlib-rs"
	"deflate-zopfli"
	"jiff-02"
	"lzma"
	"lzma-static"
	"nt-time"
	"ppmd"
	"unreserved"
	"xz"
	"xz-static"
)
