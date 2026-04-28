# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="byteorder"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for reading/writing numbers in big-endian and little-endian."
HOMEPAGE="https://github.com/BurntSushi/byteorder"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"i128"
	"std"
)
