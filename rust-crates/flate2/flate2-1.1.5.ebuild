# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="flate2"
CRATE_VERSION="1.1.5"
CRATE_CHECKSUM="bfe33edd8e85a12a67454e37f8c75e730830d83e313556ab9ebf9ee7fbeb3bfb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="DEFLATE compression and decompression exposed as Read/BufRead/Write streams. Supports miniz_oxide and multiple zlib implementations. Supports zlib, gzip, and raw deflate streams."
HOMEPAGE="https://github.com/rust-lang/flate2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"any_impl"
	"any_zlib"
	"cloudflare_zlib"
	"default"
	"miniz-sys"
	"rust_backend"
	"zlib"
	"zlib-default"
	"zlib-ng"
	"zlib-ng-compat"
	"zlib-rs"
)
