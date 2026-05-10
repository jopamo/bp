# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bzip2"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="49ecfb22d906f800d4fe833b6282cf4dc1c298f5057ca0b5445e5c209735ca47"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to libbzip2 for bzip2 compression and decompression exposed as Reader/Writer streams."
HOMEPAGE="https://github.com/trifectatechfoundation/bzip2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"libbz2-rs-sys"
	"static"
)
