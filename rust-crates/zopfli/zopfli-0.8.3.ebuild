# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zopfli"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="f05cd8797d63865425ff89b5c4a48804f35ba0ce8d125800027ad6017d2b5249"
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
