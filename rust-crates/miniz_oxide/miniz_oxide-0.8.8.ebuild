# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="miniz_oxide"
CRATE_VERSION="0.8.8"
CRATE_CHECKSUM="3be647b768db090acb35d5ec5db2b0e1f1de11133ca123b9eacf5137868f892a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="DEFLATE compression and decompression library rewritten in Rust based on miniz"
HOMEPAGE="https://github.com/Frommi/miniz_oxide/tree/master/miniz_oxide"
LICENSE="|| ( MIT Zlib Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"block-boundary"
	"default"
	"rustc-dep-of-std"
	"simd"
	"std"
	"with-alloc"
)
