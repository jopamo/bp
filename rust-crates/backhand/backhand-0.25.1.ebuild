# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="backhand"
CRATE_VERSION="0.25.1"
CRATE_CHECKSUM="72e7812fe72262dd26c2b4309c8e8f2c028db1ffbeb21054f009f847f09ca92c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for the reading, creating, and modification of SquashFS file systems"
HOMEPAGE="https://github.com/wcampbell0x2a/backhand"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"any-gzip"
	"default"
	"gzip"
	"lz4"
	"lzo"
	"parallel"
	"v3"
	"v3_lzma"
	"xz"
	"xz-static"
	"zstd"
)
