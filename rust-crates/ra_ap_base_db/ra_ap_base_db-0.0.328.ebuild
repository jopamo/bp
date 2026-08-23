# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_base_db"
CRATE_VERSION="0.0.328"
CRATE_CHECKSUM="b1567168e7c7b50acf2ffb87bde8937986d4f41c777a2c308298ede9d555c96c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Basic database traits for rust-analyzer. The concrete DB is defined by \`ide\` (aka \`ra_ap_ide\`)."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"in-rust-tree"
)
