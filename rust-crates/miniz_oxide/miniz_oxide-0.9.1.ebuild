# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="miniz_oxide"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="b63fbc4a50860e98e7b2aa7804ded1db5cbc3aff9193adaff57a6931bf7c4b4c"
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
