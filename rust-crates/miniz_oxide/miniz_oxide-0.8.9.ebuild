# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="miniz_oxide"
CRATE_VERSION="0.8.9"
CRATE_CHECKSUM="1fa76a2c86f704bdb222d66965fb3d63269ce38518b83cb0575fca855ebb6316"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="DEFLATE compression and decompression library rewritten in Rust based on miniz"
HOMEPAGE="https://github.com/Frommi/miniz_oxide/tree/master/miniz_oxide"
LICENSE="|| ( MIT Zlib Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"block-boundary"
	"default"
	"rustc-dep-of-std"
	"simd"
	"std"
	"with-alloc"
)
