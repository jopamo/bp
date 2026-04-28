# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="miniz_oxide"
CRATE_VERSION="0.7.2"
CRATE_CHECKSUM="9d811f3e15f28568be3407c8e7fdb6514c1cda3cb30683f15b6a1a1dc4ea14a7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="DEFLATE compression and decompression library rewritten in Rust based on miniz"
HOMEPAGE="https://github.com/Frommi/miniz_oxide/tree/master/miniz_oxide"
LICENSE="|| ( MIT Zlib Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
	"simd"
	"std"
	"with-alloc"
)
