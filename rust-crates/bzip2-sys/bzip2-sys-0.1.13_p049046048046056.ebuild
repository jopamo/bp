# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bzip2-sys"
CRATE_VERSION="0.1.13+1.0.8"
CRATE_CHECKSUM="225bff33b2141874fe80d71e07d6eec4f85c5c216453dd96388240f96e1acc14"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to libbzip2 for bzip2 compression and decompression exposed as Reader/Writer streams."
HOMEPAGE="https://github.com/alexcrichton/bzip2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__disabled"
	"static"
)
