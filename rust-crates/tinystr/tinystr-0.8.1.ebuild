# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tinystr"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="5d4f6d1145dcb577acf783d4e601bc1d76a13337bb54e6233add580b07344c8b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A small ASCII-only bounded length string representation."
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"default"
	"serde"
	"std"
	"zerovec"
)
