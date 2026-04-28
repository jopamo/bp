# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zip"
CRATE_VERSION="2.4.1"
CRATE_CHECKSUM="938cc23ac49778ac8340e366ddc422b2227ea176edb447e23fc0627608dddadd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library to support the reading and writing of zip files."
HOMEPAGE="https://github.com/zip-rs/zip2.git"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
