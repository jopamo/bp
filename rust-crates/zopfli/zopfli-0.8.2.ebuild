# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zopfli"
CRATE_VERSION="0.8.2"
CRATE_CHECKSUM="edfc5ee405f504cd4984ecc6f14d02d55cfda60fa4b689434ef4102aae150cd7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of the Zopfli compression algorithm."
HOMEPAGE="https://github.com/zopfli-rs/zopfli"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"gzip"
	"nightly"
	"std"
	"zlib"
)
