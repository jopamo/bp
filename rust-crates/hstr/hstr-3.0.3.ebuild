# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hstr"
CRATE_VERSION="3.0.3"
CRATE_CHECKSUM="0c43c0a9e8fbdb3bb9dc8eee85e1e2ac81605418b4c83b6b7413cbf14d56ca5c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A string type which is optimized for hash operations."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"atom_size_128"
	"atom_size_64"
	"rkyv"
	"serde"
)
